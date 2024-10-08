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

    $idUser = $modx->findResource('tarot-readers/id' . $_POST['idUser'], 'web');

    if ($idUser) {
        $resource = $modx->getObject('modResource', $idUser);
        $resourceID = $resource->get('id');
        $worktimeMIGX = $resource->getTVValue('worktime');
        $idUserInSystem = $resource->getTVValue('idUser');

        $diffTimezoneOffset = getDiffTimezoneOffset($modx, $idUserInSystem);

        $wrkCurrentArray = [];

        $arrDayWeeks = [
            'monday',
            'tuesday',
            'wednesday',
            'thursday',
            'friday',
            'saturday',
            'sunday'
        ];

        $itemNum = 0;

        foreach ($arrDayWeeks as $key => $arrDayItem) {
            $wrkNewSubArray = [];
            $wrkNewSubArray["MIGX_id"] = $itemNum;
            
            if (in_array($arrDayItem, $_POST["dayweek"])) {
                // Записываем время по Московскому времени
                $startTime = strtotime(date($_POST["time"][$arrDayItem]));
                $endTime = strtotime(date($_POST["timeEnd"][$arrDayItem]));

                $startTimeByMSK = date("H:i", $startTime - $diffTimezoneOffset);
                $endTimeByMSK   = date("H:i", $endTime - $diffTimezoneOffset);

                $wrkNewSubArray["dayweek"] = $arrDayItem;
                $wrkNewSubArray["time"] = $startTimeByMSK;
                $wrkNewSubArray["timeEnd"] = $endTimeByMSK;
                $wrkNewSubArray["active"] = "1";
            } else {
                $wrkNewSubArray["dayweek"] = $arrDayItem;
                $wrkNewSubArray["time"] = "";
                $wrkNewSubArray["timeEnd"] = "";
                $wrkNewSubArray["active"] = "0";
            }

            $wrkCurrentArray[] = $wrkNewSubArray;
            $itemNum++;
        }

        $resource->setTVValue('worktime', json_encode($wrkCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
    }

    if (!$resource->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Ошибка сохранения записи в расписание!'
        ];
    } else {
        $result = [
            'state' => 'success',
            'message' => 'Успешное сохранение графика работы'
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);