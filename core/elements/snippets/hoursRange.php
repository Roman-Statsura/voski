<?php
    function hoursRange($lower = 0, $upper = 86400, $step = 3600)
    {
        $times = [];
        foreach (range($lower, $upper, $step) as $increment)
        {
            $increment = gmdate('H:i', $increment);
            list($hour, $minutes) = explode(':', $increment);
            $date = new DateTime($hour.':'.$minutes);
            $times[] = (string) $increment;
        }
        return $times;
    }

    function timeToSec($time, $sec = 0)
    {
        foreach (array_reverse(explode(':', $time.':00')) as $k => $v)
            $sec += pow(60, $k) * $v;

        return $sec;
    }