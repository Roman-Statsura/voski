<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './yookassa/YooKassaIntegration.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $result = [
        'state' => '',
        'message' => ''
    ];

    $idConsult = $_POST["idConsult"];
    $resource = $modx->getObject('modResource', $idConsult);

    // Если ресурс существует и найден
    if ($resource) {
        $resourcePaymentID = $resource->getTVValue('consultPaymentID'); // Получаем id платежа
        $resourceDatetime = $resource->getTVValue('consultDatetime'); // Получаем дату начала консультации
        $resourceClientID = $resource->getTVValue('consultIDClient'); // Получаем id клиента

        // Подключаемся к магазину ЮКассы
        $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', "http://voski.loc/payment-status");
        $paymentInfo = $paymentClass->getPaymentInfo($resourcePaymentID); // Получаем информацию платежа с ЮКассы

        // Если информация платежа существует в системе
        if ($paymentInfo) {
            $paymentStatus = $paymentInfo->status;
            $paymentPrice = $paymentInfo->amount->value;
            $paymentDesc = $paymentInfo->description;
            
            // Создаем запрос на возврат средств в ЮКассе
            if ($paymentStatus == "succeeded") {
                $currentDatetime = time();
                $consultDatetime = strtotime("-1 day", strtotime($resourceDatetime));

                // Расчитываем процент возврата относительно даты начала консультации
                // Условие: возврат 50% суммы, если клиент отказался от консультации, позднее чем за сутки до начала
                // Иначе: полный возврат
                if ($currentDatetime >= $consultDatetime) {
                    $paymentPrice = $paymentPrice / 2;
                }

                // Получаем информацию клиента
                if ($user = $modx->getObject('modUser', $resourceClientID)) {
                    if ($profile = $user->getOne('Profile')) {
                        $extended = $profile->get('extended');

                        $clientPhone = $user->get('username');
                        $clientUserName = $profile->get('fullname');
                        $clientEmail = $profile->get('email');
                    }
                }

                $paymentReceipt = [
                    "customer" => [
                        "full_name" => $clientUserName,
                        "phone" => $clientPhone,
                    ],
                    "items" => [
                        [
                            "description" => $paymentDesc,
                            "quantity" => 1.0,
                            "amount" => [
                                "value" => number_format(floatval($paymentPrice), 1, '.', ''),
                                "currency" => "RUB"
                            ],
                            "vat_code" => "2",
                            "payment_mode" => "full_payment",
                            "payment_subject" => "service"
                        ]
                    ]
                ];
                $createRefund = $paymentClass->createRefund($resourcePaymentID, $paymentPrice, $paymentReceipt);
            } else if ($paymentStatus == "waiting_for_capture") {
                $createRefund = $paymentClass->cancelPayment($resourcePaymentID);
            } else {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка! Платеж не может быть отменен! Неверный статус! id платежа: {$resourcePaymentID} - Статус платежа: {$paymentStatus}");
                $result = [
                    'state' => 'error',
                    'message' => "Ошибка отмены консультации"
                ];
            }

            // Если запрос успешно обработан
            if ($createRefund) {
                // Ищем таролога
                $idTarot = $resource->getTVValue('consultIDTarot');
                $tarotResource = $modx->getObject('modResource', $idTarot);
                $tarotSchedule = $tarotResource->getTVValue('schedule'); // Получаем расписание таролога

                if ($tarotSchedule) {
                    $schCurrentArray = json_decode($tarotSchedule);

                    // Ищем необходимую запись в расписании
                    foreach ($schCurrentArray as $schKey => $schValue) {
                        if ($schValue->idConcult == $idConsult) {
                            unset($schCurrentArray[$schKey]); // Удаляем найденную запись
                        }
                    }

                    // Сохраняем полученое расписание
                    $tarotResource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
                    
                    if ($tarotResource->save()) {
                        // Если расписание успешно сохранилась, то удаляем саму консультацию
                        $resource->set('deleted', '1');

                        // Сохраняем результат
                        if ($resource->save()) {
                            $result = [
                                'state' => 'success',
                                'message' => "Консультация отменена"
                            ];
                        } else {
                            $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в удалении консультации! id консультации: {$idConsult}");

                            $result = [
                                'state' => 'error',
                                'message' => "Ошибка отмены консультации"
                            ];
                        }
                    } else {
                        $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в сохранении расписания таролога! id таролога: {$idTarot} - id консультации: {$idConsult}");
                        $result = [
                            'state' => 'error',
                            'message' => "Ошибка отмены консультации"
                        ];
                    }
                } else {
                    $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка! Не найдена запись о консультации в расписании таролога! id таролога: {$idTarot} - id консультации: {$idConsult}");
                    $result = [
                        'state' => 'error',
                        'message' => "Ошибка отмены консультации"
                    ];
                }
            } else {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка! В создании возврата средств! id платежа: {$resourcePaymentID} -  id консультации: {$idConsult}");
                $result = [
                    'state' => 'error',
                    'message' => "Ошибка отмены консультации"
                ];
            }
        } else {
            $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка! Не найден платеж! id платежа: {$resourcePaymentID} -  id консультации: {$idConsult}");
            $result = [
                'state' => 'error',
                'message' => "Ошибка отмены консультации"
            ];
        }
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);