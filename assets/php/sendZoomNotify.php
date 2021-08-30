<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';
    require_once './sendMail.php';
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();
    $nothingSend = true;

    $params = array(
        'parents' => 36,
        'sortby' => 'publishedon',
        'sortdir' => 'DESC',
        'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
                         consultDesc, consultStatusSession, consultDuration, consultSended',
        'includeContent' => '1',
        'return' => 'json',
        'limit' => 0
	);

	$consultationResources = json_decode($modx->runSnippet('pdoResources', $params), true);

    foreach ($consultationResources as $consultRes) {
        $idRes              = $consultRes["id"];
        $idClient           = $consultRes["tv.consultIDClient"];
        $idTarot            = $consultRes["tv.consultIDTarot"];
        $statusSession      = $consultRes["tv.consultStatusSession"];
        $startConsult       = $consultRes["tv.consultDatetime"];
        $startConsultTime   = strtotime($startConsult);
        $sendTime           = strtotime("-20 minutes", strtotime($startConsult));
        $startTime          = $consultRes["tv.consultStartTime"];
        $sended             = $consultRes["tv.consultSended"];
        $zoomID             = $consultRes["tv.consultZoomID"];
        $zoomLink           = $consultRes["tv.consultZoomLink"];

        if (!$sended) {
            if (time() >= $sendTime || $_GET["debug"] == "Y") {
                $nothingSend = false;
                $respTest = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$zoomID}", $jwtToken, "", "GET");
                $respTest = json_decode($respTest);

                if (isset($zoomLink) && !empty($zoomLink)) {
                    $currentResource = $modx->getObject('modResource', $idRes);

                    // Получаем информацию таролога
                    $resource = $modx->getObject('modResource', $idTarot);
                    $resourceID = $resource->get('id');

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

                    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $idClient);

                    $timestamp = strtotime(date($startConsult));
                    $dateFormat = "Y-m-d H:i";
                    $timezoneTime = date($dateFormat, $timestamp + $diffTimezoneOffset);
                    
                    $cnsDateTime = new DateTime($timezoneTime);

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

                    // Отправляем письмо на почту клиента
                    $properties = [
                        "clientName"    => $clientUserName,
                        "datetime"      => "{$weekDay} {$dateWithTime}",
                        "tarotName"     => $resource->get('pagetitle'),
                        "zoomID"        => $zoomID,
                        "zoomLink"      => $zoomLink,
                        "zoomPassword"  => $respTest->password
                    ];
                    
                    if (filter_var($clientEmail, FILTER_VALIDATE_EMAIL)) {
                        if (sendMail($modx, $clientEmail, "Приглашение на консультацию от таролога {$resource->get('pagetitle')} на сайте Voski", 'consultationNotify', $properties)) {
                            $currentResource->setTVValue('consultSended', 1);
                            echo "success!";
                        } else {
                            $modx->log(xPDO::LOG_LEVEL_ERROR, "Error Send Email! Email: {$clientEmail}. ID consultation - {$consultationItem->MIGX_id}");
                        }
                    } else {
                        $currentResource->setTVValue('consultSended', 1);
                        $modx->log(xPDO::LOG_LEVEL_ERROR, "Wrong Client Tarot! Email: {$clientEmail}. ID consultation - {$consultationItem->MIGX_id}");
                    }
                } else {
                    $modx->log(xPDO::LOG_LEVEL_ERROR, "Error! Empty or Not Exist Zoom Link! ID consultation - {$consultationItem->MIGX_id}");
                }
            }
        }
    }

    if (!$nothingSend) {
        if (!$currentResource->save()) {
            $modx->log(xPDO::LOG_LEVEL_ERROR, "Error! Something Wrong with Save Resource! ID - {$idRes}");
        }
    } else {
        echo "Nothing Send!";
        $modx->log(xPDO::LOG_LEVEL_ERROR, "Nothing Send!");
    }