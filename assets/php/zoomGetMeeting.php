<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';

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
            }
        }
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);