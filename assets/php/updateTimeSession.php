<?php
    require_once '../../core/model/modx/modx.class.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $meetingId = $_POST["meetingId"];
    $idRes = $_POST["id"];
    $resource = $modx->getObject('modResource', $idRes);
    $consultations = $resource->getTVValue('consultations');
    $zoomID = $resource->getTVValue('consultZoomID');
    $duration = $resource->getTVValue('consultDuration');
    $startTime = $resource->getTVValue('consultStartTime');
    $currentDiffTime = time() - strtotime($startTime);
    $changed = false;

    if (strval($zoomID) == $meetingId) {
        $duration = $currentDiffTime;
        $duration += 1;
        $changed = true;
    }

    if ($changed) {
        $resource->setTVValue('consultDuration', $duration);
        echo $duration;
    }