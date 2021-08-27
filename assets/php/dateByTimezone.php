<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    if (empty($_POST["date"])) {
        $modx->sendErrorPage(); 
    }

    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $modx->user->id);

    $timestamp = strtotime(date($_POST["date"]));
    $dateFormat = empty($_POST["dateFormat"]) ? "d.m.Y H:i" : $_POST["dateFormat"];

    $timezoneTime = date($dateFormat, $timestamp + $diffTimezoneOffset);
    echo $timezoneTime;