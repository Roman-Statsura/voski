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
    $status = $resource->getTVValue('consultStatusSession');
    $startTime = $resource->getTVValue('consultStartTime');
    $changed = false;

    if ($status == 1 || $status == 4) {
        if (!empty($startTime)) {
            $currentDiffTime = time() - strtotime($startTime);

            if (strval($zoomID) == $meetingId) {
                $duration = $currentDiffTime;
                $changed = true;
            }
        }
    }

    if ($changed) {
        $resource->setTVValue('consultDuration', $duration);
        echo $duration;
    }