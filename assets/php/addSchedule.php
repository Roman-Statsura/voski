<?php
    require_once '../../core/model/modx/modx.class.php';
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
                    $schCurrentItem->datetime = $_POST['date'] . " " . $_POST['time'];
                    $schCurrentItem->datetimeEnd = $_POST['date'] . " " . $_POST['timeEnd'];
                    $schCurrentItem->allDay = empty($_POST['allDay']) ? 0 : $_POST['allDay'];
                    $schCurrentItem->desc = $_POST['desc'];
                    $schCurrentItem->status = empty($_POST['status']) ? 0 : $_POST['status'];
                }
            }
            
            $message = "Запись успешно изменена";
        }
        $resource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
    } else {
        $schNewSubArray = [];
        $schNewSubArray["MIGX_id"] = end($schCurrentArray)->MIGX_id + 1;
        $schNewSubArray["datetime"] = $_POST['date'] . " " . $_POST['time'];
        $schNewSubArray["datetimeEnd"] = $_POST['date'] . " " . $_POST['timeEnd'];
        $schNewSubArray["allDay"] = empty($_POST['allDay']) ? 0 : $_POST['allDay'];
        $schNewSubArray["idUser"] = $_POST['idUser'];
        $schNewSubArray["desc"] = $_POST['desc'];
        $schNewSubArray["status"] = empty($_POST['status']) ? 0 : $_POST['status'];
        $schNewSubArray["active"] = '1';
    
        $schCurrentArray[] = $schNewSubArray;
        $resource->setTVValue('schedule', json_encode($schCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
        $message = "Запись успешно добавлена";
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

        $newArray[] = $schCurrentItem;
    }

    if (!$resource->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Ошибка сохранения записи в расписание!'
        ];
    } else {
        $result = [
            'state' => 'success',
            'message' => $message,
            'res' => $newArray
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);