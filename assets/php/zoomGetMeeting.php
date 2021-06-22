<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';
    require_once './sendMail.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();

    $idRes = $_GET["id"];
    $meetingId = $_GET["meetingId"];
    $action = $_GET["action"];

    $resource = $modx->getObject('modResource', $idRes);
    $zoomID = $resource->getTVValue('consultZoomID');
    $statusSessionField = $resource->getTVValue('consultStatusSession');
    $startTimeField = $resource->getTVValue('consultStartTime');
    $idClient = $resource->getTVValue('consultIDClient');
    $idTarot = $resource->getTVValue('consultIDTarot');
    $consultDatetime = $resource->getTVValue('consultDatetime');

    if (empty($action)) {
        if (strval($zoomID) == $meetingId) {
            $zoomMeeting = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$meetingId}", $jwtToken, false, "GET");
            $zoomMeeting = json_decode($zoomMeeting);

            if ($zoomMeeting->id) {
                if ($zoomMeeting->status == "started") {
                    $statusSession = 4;

                    if (empty($startTimeField)) {
                        $startTime = date("Y-m-d H:i:s", time());
                    }
                } else {
                    if ($statusSessionField == 4) {
                        $statusSession = 1;
                    } else {
                        $statusSession = 4;

                        if (empty($startTimeField)) {
                            $startTime = date("Y-m-d H:i:s", time());
                        }
                    }
                }
            }
        }

        $resource->setTVValue('consultStatusSession', $statusSession);
        if (!empty($startTime)) {
            $resource->setTVValue('consultStartTime', $startTime);
        }

        if (!$resource->save()) {
            $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в сохранений ресурса! ID: {$idRes}.");
            $result = [
                'state' => 'error',
                'message' => 'Something Error!'
            ];
        } else {
            $modx->log(xPDO::LOG_LEVEL_ERROR, "S'all good man! ID: {$idRes} || Status: {$idRes} || Start Time {$startTime}.");
            $result = [
                'state' => 'success',
                'message' => 'Консультация успешно началась'
            ];
        }
    } else if ($action == "end") {
        if ($statusSessionField == 4) {
            $zoomMeeting = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$meetingId}/status", $jwtToken, ["action" => "end"], "PUT");
            $zoomMeeting = json_decode($zoomMeeting);

            $resource->setTVValue('consultStatusSession', 1);

            if (!$resource->save()) {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в сохранений ресурса при завершении! ID: {$idRes}.");
                $result = [
                    'state' => 'error',
                    'message' => 'Something Error!'
                ];
            } else {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "S'all good man! ID: {$idRes} || Status: {$idRes} || Start Time {$startTime}.");
                $result = [
                    'state' => 'success',
                    'message' => 'Консультация завершена'
                ];

                $cnsDateTime = new DateTime($consultDatetime);

                $arr = array(
                    '01' => 'Января',
                    '02' => 'Февраля',
                    '03' => 'Марта',
                    '04' => 'Апреля',
                    '05' => 'Мая',
                    '06' => 'Июня',
                    '07' => 'Июля',
                    '08' => 'Августа',
                    '09' => 'Сентября',
                    '10' => 'Октября',
                    '11' => 'Ноября',
                    '12' => 'Декабря'
                );
        
                $arrData = array(
                    '1' => 'Понедельник',
                    '2' => 'Вторник',
                    '3' => 'Среда',
                    '4' => 'Четверг',
                    '5' => 'Пятница',
                    '6' => 'Суббота',
                    '7' => 'Воскресенье'
                );
        
                $weekDay = $arrData[$cnsDateTime->format('N')];
                $dateWithTime = "{$cnsDateTime->format('d')} {$arr[$cnsDateTime->format('m')]} {$cnsDateTime->format('H:i')}";
        
                // Получаем информацию клиента
                $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $idClient;
                $statement = $modx->query($sql);
                $users = $statement->fetchAll(PDO::FETCH_ASSOC);
                $clientUserName = "";
                $clientEmail = "";
        
                foreach ($users as $user) {
                    $clientUserName = $user["fullname"];
                    $clientEmail = $user["email"];
                }
        
                $tarotRes = $modx->getObject('modResource', $idTarot);
        
                // Отправляем письмо на почту клиента
                $properties = [
                    "clientName"    => $clientUserName,
                    "datetime"      => "{$weekDay} {$dateWithTime}",
                    "tarotName"     => $tarotRes->get('pagetitle'),
                    "ratingLink"    => "{$resource->get('uri')}?getIDClient={$idClient}"
                ];
                if (filter_var($clientEmail, FILTER_VALIDATE_EMAIL)) {
                    sendMail($modx, $clientEmail, "Консультация завершена {$weekDay} {$dateWithTime} на сайте Voski", 'consultationEnd', $properties);
                } else {
                    $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в отправке письма о завершений! ID: {$resource->get('id')}");
                }
            }
        }
    } else if ($action == "debug") {
        $cnsDateTime = new DateTime($consultDatetime);

        $arr = array(
            '01' => 'Января',
            '02' => 'Февраля',
            '03' => 'Марта',
            '04' => 'Апреля',
            '05' => 'Мая',
            '06' => 'Июня',
            '07' => 'Июля',
            '08' => 'Августа',
            '09' => 'Сентября',
            '10' => 'Октября',
            '11' => 'Ноября',
            '12' => 'Декабря'
        );

        $arrData = array(
            '1' => 'Понедельник',
            '2' => 'Вторник',
            '3' => 'Среда',
            '4' => 'Четверг',
            '5' => 'Пятница',
            '6' => 'Суббота',
            '7' => 'Воскресенье'
        );

        $weekDay = $arrData[$cnsDateTime->format('N')];
        $dateWithTime = "{$cnsDateTime->format('d')} {$arr[$cnsDateTime->format('m')]} {$cnsDateTime->format('H:i')}";

        // Получаем информацию клиента
        $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $idClient;
        $statement = $modx->query($sql);
        $users = $statement->fetchAll(PDO::FETCH_ASSOC);
        $clientUserName = "";
        $clientEmail = "";

        foreach ($users as $user) {
            $clientUserName = $user["fullname"];
            $clientEmail = $user["email"];
        }

        $tarotRes = $modx->getObject('modResource', $idTarot);

        // Отправляем письмо на почту клиента
        $properties = [
            "clientName"    => $clientUserName,
            "datetime"      => "{$weekDay} {$dateWithTime}",
            "tarotName"     => $tarotRes->get('pagetitle'),
            "ratingLink"    => "{$resource->get('uri')}?getIDClient={$idClient}"
        ];

        if (filter_var($clientEmail, FILTER_VALIDATE_EMAIL)) {
            sendMail($modx, $clientEmail, "Консультация завершена {$weekDay} {$dateWithTime} на сайте Voski", 'consultationEnd', $properties);

            $result = [
                'state' => 'success',
                'message' => 'debug12'
            ];
        } else {
            $result = [
                'state' => 'error',
                'message' => 'Something Error!'
            ];
        }
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);