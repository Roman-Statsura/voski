<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';
    require_once './sendMail.php';
    require_once './uniqueAliasGenerator.php';
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    // Zoom API JWT App
    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();

    $result = [
        'state' => '',
        'message' => ''
    ];

    function translit($str) {
        $str = (string) $str;
        $str = strip_tags($str);
        $str = str_replace(array("\n", "\r"), " ", $str);
        $str = preg_replace("/\s+/", ' ', $str);
        $str = trim($str); // убираем пробелы в начале и конце строки
        $str = function_exists('mb_strtolower') ? mb_strtolower($str) : strtolower($str);
        $ABC = array(
            'а' => 'a', 'б' => 'b', 'в' => 'v', 'г' => 'g', 'д' => 'd', 'е' => 'e', 'ё' => 'e', 'ж' => 'j', 'з' => 'z', 'и' => 'i',
            'й' => 'y', 'к' => 'k', 'л' => 'l', 'м' => 'm', 'н' => 'n', 'о' => 'o', 'п' => 'p', 'р' => 'r', 'с' => 's', 'т' => 't', 'у' => 'u',
            'ф' => 'f', 'х' => 'h', 'ц' => 'c', 'ч' => 'ch', 'ш' => 'sh', 'щ' => 'shch', 'ы' => 'y', 'э' => 'e', 'ю' => 'yu', 'я' => 'ya', 'ъ' => '', 'ь' => ''
        );
        $str = strtr($str, $ABC);
        $str = preg_replace("/[^0-9a-z-_ ]/i", "", $str);
        $str = str_replace(" ", "-", $str);
        return $str;
    }

    $resource = $modx->getObject('modResource', $_POST['idTarot']);
    $resourceID = $resource->get('id');
    $scheduleMIGX = $resource->getTVValue('schedule');
    $systemUserID = $resource->getTVValue('idUser');
    $description = "";

    if ($scheduleMIGX) {
        $schCurrentArray = json_decode($scheduleMIGX);
    } else {
        $schCurrentArray = [];
    }

    if (!empty($_POST['idUser'])) {
        $resConsultation = $modx->getObject('modResource', 1);
        $resConsultationID = $resConsultation->get('id');
        $consultationMIGX = $resConsultation->getTVValue('consultations');

        if ($consultationMIGX) {
            $cnsCurrentArray = json_decode($consultationMIGX);
        } else {
            $cnsCurrentArray = [];
        }

        // Получаем информацию клиента
        $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $_POST['idUser'];
        $statement = $modx->query($sql);
        $users = $statement->fetchAll(PDO::FETCH_ASSOC);
        $clientUserName = "";
        $clientEmail = "";
        $tarotEmail = "";

        foreach ($users as $user) {
            $clientUserName = $user["fullname"];
            $clientEmail = $user["email"];
        }

        // Получаем информацию таролога
        $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $systemUserID;
        $statement = $modx->query($sql);
        $tarots = $statement->fetchAll(PDO::FETCH_ASSOC);
        $tarotEmail = "";

        foreach ($tarots as $tarot) {
            $tarotEmail = $tarot["email"];
        }

        $diffTimezoneOffset = getDiffTimezoneOffset($modx, $_POST['idUser']);

        $timestamp = strtotime(date($_POST['schTime']));
        $dateFormat = "Y-m-d H:i";
        // Переводим в МСК часовой пояс для Zoom
        $timezoneTime = date($dateFormat, $timestamp - $diffTimezoneOffset);

        // Создаем конференцию в Zoom
        $title = "Консультация с клиентом {$clientUserName} на дату {$timezoneTime}";
        $query = array(
            "topic"      => $title,
            "type"       => 2,
            "start_time" => date("Y-m-d\TH:i:s", strtotime($timezoneTime)),
            "timezone"   => "Europe/Moscow",
            "duration"   => "60",
            "password"   => "123456"
        );

        $activeZoomUser = $jwt->cURLQueries("https://api.zoom.us/v2/users/{$tarotEmail}", $jwtToken, false, "GET");
        $activeZoomUser = json_decode($activeZoomUser);

        $respTest = $jwt->cURLQueries("https://api.zoom.us/v2/users/{$activeZoomUser->id}/meetings", $jwtToken, $query);
        $respTest = json_decode($respTest);

        // Записываем запись тарологу
        $description = "<span>Подключиться к консультации Zoom</span><br>
                        <span><a href='{$respTest->join_url}' target='_blank'>{$respTest->join_url}</a></span><br>
                        <span>Идентификатор конференции: $respTest->id</span><br>
                        <span>Код доступа: $respTest->password</span>";

        // Заполняем общую таблицу консультации
        $newResource = $modx->newObject('modDocument');

        $newResource->set('pagetitle', $title);
        $newResource->set('content', $description);
        $newResource->set('alias', uniqueAliasGenerator());
        $newResource->set('published', 1);
        $newResource->set('template', 20);
        $newResource->set('parent', 36);
                
        if (!$newResource->save()) {
            $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка сохранения ресурса с именем в id: {$docId}");
        } else {
            $docId = $newResource->get('id');
            $tvs = $modx->getObject('modResource', $docId);
            $tvs->setTVValue('consultDatetime', $timezoneTime);
            $tvs->setTVValue('consultIDClient', $_POST['idUser']);
            $tvs->setTVValue('consultIDTarot', $_POST['idTarot']);
            $tvs->setTVValue('consultZoomID', $respTest->id);
            $tvs->setTVValue('consultZoomLink', $respTest->join_url);
            $tvs->setTVValue('consultZoomStartLink', $respTest->start_url);
            $tvs->setTVValue('consultDesc', $description);
            $tvs->setTVValue('consultPaymentID', $_POST['paymentID']);
            $tvs->setTVValue('consultStatusSession', 0);
            $tvs->setTVValue('consultDuration', 0);
            $tvs->setTVValue('consultSended', 0);
            
            if (!$tvs->save()) {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка сохранения дополнительных полей в id: {$docId}");
            }

            $schNewSubArray = [];
            $schNewSubArray["MIGX_id"] = end($schCurrentArray)->MIGX_id + 1;
            $schNewSubArray["datetime"] = $timezoneTime;
            $schNewSubArray["allDay"] = 0;
            $schNewSubArray["idUser"] = $_POST['idUser'];
            $schNewSubArray["zoomLink"] = $respTest->join_url;
            $schNewSubArray["desc"] = $description;
            $schNewSubArray["idConcult"] = $docId;
            $schNewSubArray["status"] = 2;
            $schNewSubArray["active"] = '1';
        
            $schCurrentArray[] = $schNewSubArray;
            $resource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

            if (!$resource->save()) {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка сохранения расписания к тарологу: id таролога: {$_POST['idTarot']}");
            }
        }

        $cnsDateTime = new DateTime($_POST['schTime']);
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

        $message = "Вы успешно записаны на {$weekDay} {$dateWithTime}, Ваш таролог - {$resource->get('pagetitle')}";

        // Отправляем письмо на почту клиента, об успешной записи
        $properties = [
            "clientName" => $clientUserName,
            "datetime"   => "{$weekDay} {$dateWithTime}",
            "tarotName"  => $resource->get('pagetitle')
        ];
        sendMail($modx, $clientEmail, "Вы успешно записаны на {$weekDay} {$dateWithTime}, на сайте Voski", 'consultationEmail', $properties);
    }

    if (!$resConsultation->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Ошибка сохранения записи на консультацию!'
        ];
    } else {
        $result = [
            'state' => 'success',
            'message' => $message,
            'res' => $cnsCurrentArray
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);