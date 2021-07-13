<?php
    /**
     * YooKassaIntegration Class Test
     * Test Shop Voski
     */
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    header('Content-Type: application/json');

    require_once './yookassa/YooKassaIntegration.php';
    require_once '../../core/elements/snippets/profile/encrypt.php';

    $user_id = $_POST["idUser"];
    $redirectURL = "{$modx->getOption('site_url')}payment-status";

    // Testing
    $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', $redirectURL);

    if ($_GET["type"] == "checkNewCard") {
        if (!empty($_POST["cardname"]) && !empty($_POST["creditnumber"]) && !empty($_POST["datefinished"]) && !empty($_POST["cvc"])) {
            $dateFinished = explode("/", $_POST["datefinished"]);
            $dateMonth = DateTime::createFromFormat('m', $dateFinished[0]);
            $dateYear = DateTime::createFromFormat('y', $dateFinished[1]);

            $paymentCard = [
                "type" => "bank_card",
                "card" => [
                    "cardholder" => $_POST["cardname"],
                    "number" => str_replace(" ", "", $_POST["creditnumber"]),
                    "expiry_month" => $dateFinished[0],
                    "expiry_year" => $dateYear->format('Y'),
                    "csc" => $_POST["cvc"]
                ]
            ];

            // Получаем информацию клиента
            if ($user = $modx->getObject('modUser', $_POST['idUser'])) {
                if ($profile = $user->getOne('Profile')) {
                    $extended = $profile->get('extended');
                    $clientPhone = $user->get('username');
                    $clientUserName = $profile->get('fullname');

                    $paymentReceipt = [
                        "customer" => [
                            "full_name" => $clientUserName,
                            "phone" => $clientPhone,
                        ],
                        "items" => [
                            [
                                "description" => "Проверка актуальности карты для привязки",
                                "quantity" => 1.0,
                                "amount" => [
                                    "value" => 1.0,
                                    "currency" => "RUB"
                                ],
                                "vat_code" => "2",
                                "payment_mode" => "full_payment",
                                "payment_subject" => "service"
                            ]
                        ]
                    ];
                }
            }
        }
    } else {
        $cnsDateTime = new DateTime($_POST['schTime']);

        $arr = array('01' => 'Января', '02' => 'Февраля', '03' => 'Марта', '04' => 'Апреля', '05' => 'Мая', '06' => 'Июня', '07' => 'Июля', '08' => 'Августа', '09' => 'Сентября', '10' => 'Октября', '11' => 'Ноября', '12' => 'Декабря');
        $arrData = array('1' => 'Понедельник', '2' => 'Вторник', '3' => 'Среда', '4' => 'Четверг', '5' => 'Пятница', '6' => 'Суббота', '7' => 'Воскресенье');
    
        $resource = $modx->getObject('modResource', $_POST['idTarot']);
        $weekDay = $arrData[$cnsDateTime->format('N')];
        $dateWithTime = "{$cnsDateTime->format('d')} {$arr[$cnsDateTime->format('m')]} {$cnsDateTime->format('H:i')}";
    
        // Получаем информацию клиента
        if ($user = $modx->getObject('modUser', $_POST['idUser'])) {
            if ($profile = $user->getOne('Profile')) {
                $extended = $profile->get('extended');
    
                $dateFinished = explode("/", $extended["datefinished"]);
                $dateMonth = DateTime::createFromFormat('m', $dateFinished[0]);
                $dateYear = DateTime::createFromFormat('y', $dateFinished[1]);

                $paymentCard = [
                    "type" => "bank_card",
                    "card" => [
                        "cardholder" => $extended["cardname"],
                        "number" => str_replace(" ", "", $extended["creditnumber"]),
                        "expiry_month" => $dateFinished[0],
                        "expiry_year" => $dateYear->format('Y'),
                        "csc" => mc_decrypt($extended["cvc"], ENCRYPTION_KEY)
                    ]
                ];

                $clientPhone = $user->get('username');
                $clientUserName = $profile->get('fullname');
                $clientEmail = $profile->get('email');
                $message = "Запись на консультацию от $clientUserName (id: {$_POST['idUser']}) на дату {$weekDay} {$dateWithTime}, к тарологу - {$resource->get('pagetitle')} (id: {$_POST['idTarot']})";    

                $paymentReceipt = [
                    "customer" => [
                        "full_name" => $clientUserName,
                        "phone" => $clientPhone,
                    ],
                    "items" => [
                        [
                            "description" => $message,
                            "quantity" => 1.0,
                            "amount" => [
                                "value" => number_format(floatval($_POST["subjectSum"]), 1, '.', ''),
                                "currency" => "RUB"
                            ],
                            "vat_code" => "2",
                            "payment_mode" => "full_payment",
                            "payment_subject" => "service"
                        ]
                    ]
                ];
            }
        }
    }

    switch ($_GET["type"]) {
        case "checkNewCard":
            $subjectTitle = "Проверка актуальности карты для привязки";
            $price = 1.0;
            $capture = true;
            break;
        default:
            $subjectTitle = $message;
            $price = number_format(floatval($_POST["subjectSum"]), 1, '.', '');
            $capture = false;
            break;
    }

    switch ($_GET["action"]) {
        case "createPayment":
            $payment = $paymentClass->createPayment($subjectTitle, $price, $paymentCard, $paymentReceipt, $capture);
            echo json_encode($payment, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            break;
        case "capturePayment":
            $payment = $paymentClass->capturePayment($_POST["paymentID"], $_POST["paymentPrice"]);
            break;
        case "cancelPayment":
            $payment = $paymentClass->cancelPayment($_POST["paymentID"]);
            break;
        case "createRefund":
            $payment = $paymentClass->createRefund($_POST["paymentID"], 1.0);
            break;
        case "getPaymentInfo":
            $payment = $paymentClass->getPaymentInfo($_REQUEST["paymentID"]);
            echo json_encode($payment, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            break;
        case "getReceipts":
            $receipts = $paymentClass->getReceipts(array('payment_id' => $_POST["paymentID"]));
            foreach ($receipts->getItems() as $receipt) {
                $receipt["formattedDate"] = $receipt["registered_at"]->format('d.m.Y H:i:s');
                echo json_encode($receipt, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            }
            break;
        case "getReceiptInfo":
            $receipt = $paymentClass->getReceiptInfo($_POST["receiptID"]);
            echo json_encode($receipt, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            break;
        default:
            $payment = "Nothing";
            break;
    }