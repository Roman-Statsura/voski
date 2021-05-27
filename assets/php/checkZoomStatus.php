<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwtToken = $jwt->JWTTokenGenerate();

    $currentUser = $_POST["currentUser"];
    $currentUserGroup = $_POST["curUserGroup"];
    $nothingSave = true;

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
        $idRes          = $consultRes["id"];
        $idClient       = $consultRes["tv.consultIDClient"];
        $idTarot        = $consultRes["tv.consultIDTarot"];
        $statusSession  = $consultRes["tv.consultStatusSession"];
        $startTime      = $consultRes["tv.consultStartTime"];

        if ($statusSession != 1 && $statusSession != 2 && $statusSession != 3) {
            $currentResource = $modx->getObject('modResource', $idRes);
            $zoomID = $consultRes["tv.consultZoomID"];
            
            $zoomConsult = $jwt->cURLQueries("https://api.zoom.us/v2/meetings/{$zoomID}", $jwtToken, false, "GET");
            $zoomConsult = json_decode($zoomConsult);

            if ($statusSession == 0 && $zoomConsult->status == "started") {
                $currentResource->setTVValue('consultStatusSession', 4);
                if (empty($startTime)) {
                    $currentResource->setTVValue('consultStartTime', date("Y-m-d H:i:s"));
                }
                $nothingSave = false;
            } else if ($statusSession == 4 && $zoomConsult->status == "waiting") {
                $currentResource->setTVValue('consultStatusSession', 1);
                $nothingSave = false;
            }

            if (!$nothingSave) {
                if (!$currentResource->save()) {
                    $modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка в сохранений ресурса! ID: {$idRes}.");
                } else {
                    $updResource = $modx->getObject('modResource', $idRes);
                    echo json_encode($updResource->toArray(), JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                }
            }
        }
    }