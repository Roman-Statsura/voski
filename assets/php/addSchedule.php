<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $result = [
        'state' => '',
        'message' => ''
    ];

    $resource = $modx->getObject('modResource', $_POST['profileID']);
    $resourceID = $resource->get('id');
    $scheduleMIGX = $resource->getTVValue('schedule');
    $idUserInSystem = $resource->getTVValue('idUser');
    
    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $idUserInSystem);

    if ($scheduleMIGX) {
        $schCurrentArray = json_decode($scheduleMIGX);
    } else {
        $schCurrentArray = [];
    }

    if (!empty($_POST["migxID"])) {
        if ($_POST['action'] == "remove") {
            foreach ($schCurrentArray as $key => $schCurrentItem) {
                if ($schCurrentItem->MIGX_id == $_POST["migxID"]) {
                    unset($schCurrentArray[$key]);
                }
            }

            $schCurrentArray = array_values($schCurrentArray);
            $message = "Запись успешно удалена";
        } else {
            foreach ($schCurrentArray as $schCurrentItem) {
                if ($schCurrentItem->MIGX_id == $_POST["migxID"]) {
                    $startTime      = strtotime(date($_POST['date'] . " " . $_POST['time']));
                    $startTimeByMSK = date("Y-m-d H:i", $startTime - $diffTimezoneOffset);
        
                    if (!empty($_POST['timeEnd'])) {
                        $endTime      = strtotime(date($_POST['date'] . " " . $_POST['timeEnd']));
                        $endTimeByMSK = date("Y-m-d H:i", $endTime - $diffTimezoneOffset);
                    } else {
                        $endTimeByMSK = $_POST['date'] . " " . $_POST['timeEnd'];
                    }

                    $schCurrentItem->datetime = $startTimeByMSK;
                    $schCurrentItem->datetimeEnd = $endTimeByMSK;
                    $schCurrentItem->allDay = empty($_POST['allDay']) ? 0 : $_POST['allDay'];
                    $schCurrentItem->desc = $_POST['desc'];
                    $schCurrentItem->status = empty($_POST['status']) ? 0 : $_POST['status'];
                }
            }
            
            $message = "Запись успешно изменена";
        }
        $resource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
    } else {
        if (!empty($_POST['time'])) {
            $startTime      = strtotime(date($_POST['date'] . " " . $_POST['time']));
            $startTimeByMSK = date("Y-m-d H:i", $startTime - $diffTimezoneOffset);

            if (!empty($_POST['timeEnd'])) {
                $endTime      = strtotime(date($_POST['date'] . " " . $_POST['timeEnd']));
                $endTimeByMSK = date("Y-m-d H:i", $endTime - $diffTimezoneOffset);
            } else {
                $endTimeByMSK = $_POST['date'] . " " . $_POST['timeEnd'];
            }

            $schNewSubArray = (object)[];
            $schNewSubArray->MIGX_id = end($schCurrentArray)->MIGX_id + 1;
            $schNewSubArray->datetime = $startTimeByMSK;
            $schNewSubArray->datetimeEnd = $endTimeByMSK;
            $schNewSubArray->allDay = empty($_POST['allDay']) ? 0 : $_POST['allDay'];
            $schNewSubArray->idUser = $_POST['idUser'];
            $schNewSubArray->desc = $_POST['desc'];
            $schNewSubArray->status = empty($_POST['status']) ? 0 : $_POST['status'];
            $schNewSubArray->active = '1';
        
            $schCurrentArray[] = $schNewSubArray;
            $resource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
            $message = "Запись успешно добавлена";
        } else {
            $state = "error";
            $message = "Ошибка сохранения записи в расписание! Пустое значение времени!";
        }
    }

    $newArray = [];
    foreach ($schCurrentArray as $schCurrentItem) {
        if (!empty($schCurrentItem->idUser)) {
            $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $schCurrentItem->idUser;
            $statement = $modx->query($sql);
            $users = $statement->fetchAll(PDO::FETCH_ASSOC);
    
            foreach ($users as $user) {
                $schCurrentItem->username = $user['fullname'];
            }
        }

        $datetime = strtotime(date($schCurrentItem->datetime));
        $datetimeByMSK = date("Y-m-d H:i", $datetime + $diffTimezoneOffset);
        $schCurrentItem->datetime = $datetimeByMSK;

        $newArray[] = $schCurrentItem;
    }

    if (!$resource->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Ошибка сохранения записи в расписание!',
            'res' => $newArray
        ];
    } else {
        $result = [
            'state' => empty($state) ? "success" : $state,
            'message' => $message,
            'res' => $newArray
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);