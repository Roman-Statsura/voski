<?php
$scheduleJSON = json_decode($schedule, true);
    
    uasort($scheduleJSON, function($a, $b) {
        return $a['datetime'] > $b['datetime'];
    });
    
    $dateArray = [];
    $date = [];
    $time = [];

    foreach ($scheduleJSON as $schItem) {
        $info = [];
        $newDate = new DateTime($schItem['datetime']);

        if ($newDate->format('Y-m-d') > date("Y-m-d")) {
            if (strpos($schItem['datetime'], $newDate->format('Y-m-d')) !== false) {
                $info["time"] = $newDate->format('H:i');
                $info["status"] = $schItem['status'];

                $date[$newDate->format('Y-m-d')][] = $info;
            }

            $dateArray = $date;
        }
    }
    
    return $dateArray;