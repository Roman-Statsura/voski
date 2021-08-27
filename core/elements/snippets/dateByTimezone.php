<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';
    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $modx->user->id);

    $timestamp = strtotime(date($dateTimeConsult));
    $dateFormat = empty($dateFormat) ? "d.m.Y H:i" : $dateFormat;

    $timezoneTime = date($dateFormat, $timestamp + $diffTimezoneOffset);
    return $timezoneTime;