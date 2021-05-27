<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();

    $meetingId = $_GET["meetingId"];
    /*$zoomMeeting = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$meetingId}/status", $jwtToken, ["action" => "end"], "PUT");
    $zoomMeeting = json_decode($zoomMeeting);*/

    $zoomMeeting = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$meetingId}", $jwtToken, false, "GET");
    $zoomMeeting = json_decode($zoomMeeting);

    var_dump($zoomMeeting);