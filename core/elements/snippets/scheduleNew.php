<?php
$worktimeArray = json_decode($worktime);
    $dateArray = [];
    $dateArraySch = [];

    $scheduleJSON = json_decode($schedule, true);
    
    uasort($scheduleJSON, function($a, $b) {
        return $a['datetime'] > $b['datetime'];
    });

    function timeSplit($time) {
        $str = explode(":", $time);
        return $str;
    }

    foreach ($scheduleJSON as $schItem) {
        $infoSch = [];
        $newDate = new DateTime($schItem['datetime']);

        if (strpos($schItem['datetime'], $newDate->format('Y-m-d')) !== false) {
            $date[$newDate->format('Y-m-d')][] = $newDate->format('H:i');
        }

        $dateArraySch = $date;
    }
    
    function hoursRange($lower = 0, $upper = 86400, $step = 3600, $currentDate = "", $dateArraySch = [])
    {
        $times = [];

        foreach (range($lower, $upper, $step) as $increment)
        {
            $increment = gmdate('H:i', $increment);
            list($hour, $minutes) = explode(':', $increment);
            $date = new DateTime($hour.':'.$minutes);

            if (!empty($currentDate)) {
                if ($currentDate . " " . $increment >= date("Y-m-d H:i")) {
                    if (!empty($dateArraySch)) {
                        if (!in_array((string) $increment, $dateArraySch[$currentDate])) {
                            $times[] = (string) $increment;
                        }
                    } else {
                        $times[] = (string) $increment;
                    }
                }
            } else {
                $times[] = (string) $increment;
            }
        }
        return $times;
    }

    function timeToSec($time, $sec = 0)
    {
        foreach (array_reverse(explode(':', $time.':00')) as $k => $v)
            $sec += pow(60, $k) * $v;

        return $sec;
    }

    foreach ($worktimeArray as $worktimeItem) {
        $info = [];
        $workDate = date("Y-m-d", strtotime($worktimeItem->dayweek . ' this week'));
        
        if ($workDate >= date("Y-m-d")) {
            if (!empty($worktimeItem->time) && !empty($worktimeItem->timeEnd)) {
                $range = hoursRange(timeToSec($worktimeItem->time), timeToSec($worktimeItem->timeEnd), 60 * 60, $workDate, $dateArraySch);                
                $dateArray[$workDate] = $range;
            }
        }
    }

    return $dateArray;