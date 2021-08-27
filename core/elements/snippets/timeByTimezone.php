<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $modx->user->id);

    $time = strtotime(date($time));
    $timeByUserTime = date("H:i", $time + $diffTimezoneOffset);

    return $timeByUserTime;