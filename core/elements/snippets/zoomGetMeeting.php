<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/zoomJWT/jwtTokenGenerator.php';

    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();

    $resource = $modx->getObject('modResource', 1);
    $consultations = $resource->getTVValue('consultations');
    $zoomID = $resource->getTVValue('zoomID');

    $newConsultationArray = [];

    foreach (json_decode($consultations) as $key => $value) {
        if (strval($value->zoomID) == $meetingId) {
            $zoomMeeting = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$meetingId}", $jwtToken, false, "GET");
            $zoomMeeting = json_decode($zoomMeeting);

            if ($zoomMeeting->id) {
                if ($zoomMeeting->status == "started") {
                    $value->statusSession = 4;
                } else {
                    $value->statusSession = 1;
                }
            }

            $newConsultationArray[] = $value;
        }
    }

    /*$resource->setTVValue('consultations', json_encode($newConsultationArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

    if (!$resource->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Error'
        ];
    } else {
        $result = [
            'state' => 'success',
            'message' => 'Success'
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);*/