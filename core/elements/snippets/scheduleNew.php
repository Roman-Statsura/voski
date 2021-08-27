<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/date/diffTimezoneOffset.php';

    if (empty($idTarot)) {
        $modx->sendErrorPage(); 
    }

    $diffTimezoneOffset = getDiffTimezoneOffset($modx, $modx->user->id);

    $resource = $modx->getObject('modResource', $idTarot);
    $worktimeMIGX = $resource->getTVValue('worktime');
    $scheduleMIGX = $resource->getTVValue('schedule');

    $worktimeArray   = json_decode($worktimeMIGX);
    $dateArray       = [];
    $dateArrayNewDay = [];
    $dateArraySch    = [];

    $scheduleJSON = json_decode($scheduleMIGX, true);
    
    uasort($scheduleJSON, function($a, $b) {
        return $a['datetime'] > $b['datetime'];
    });

    function timeSplit($time) {
        $str = explode(":", $time);
        return $str;
    }

    // Просматриваем массив "Расписание" у таролога
    // Если время совпало с графиком, то убираем из списка
    foreach ($scheduleJSON as $schItem) {
        $infoSch = [];
        $newDate = new DateTime($schItem['datetime']);

        if (strpos($schItem['datetime'], $newDate->format('Y-m-d')) !== false) {
            $timeByTimezone = timeToSec($newDate->format('H:i'), $diffTimezoneOffset);
            $date[$newDate->format('Y-m-d')][] = gmdate('H:i', $timeByTimezone);
        }

        $dateArraySch = $date;
    }

    // Формируем массив времени по интервалу
    function hoursRange($lower = 0, $upper = 86400, $step = 3600, $currentDate = "", $dateArraySch = [], $diffTimezoneOffset)
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

    // Переводим часы в секунды
    function timeToSec($time, $sec = 0)
    {
        foreach (array_reverse(explode(':', $time.':00')) as $k => $v)
            $sec += pow(60, $k) * $v;

        return $sec;
    }

    foreach ($worktimeArray as $worktimeItem) {
        $info = [];
        $newDayArray = false;
        $prevDayArray = false;
        $workDate = date("Y-m-d", strtotime($worktimeItem->dayweek . ' this week'));
        
        if ($workDate >= date("Y-m-d")) {
            if (!empty($worktimeItem->time) && !empty($worktimeItem->timeEnd)) {
                $startTimeToSec = timeToSec($worktimeItem->time, $diffTimezoneOffset);
                $endTimeToSec   = timeToSec($worktimeItem->timeEnd, $diffTimezoneOffset);
                
                if ($startTimeToSec == 86400) {
                    $startTimeToSec = 0;
                }
                
                if ($startTimeToSec < 0) {
                    $prevDayArray = true;
                    $oldLower = $startTimeToSec;
                    $oldUpper = -3600;
                    $startTimeToSec = 0;
                } else if ($startTimeToSec > 86400) {
                    $oldLower = $startTimeToSec - 86400;
                    
                    if ($endTimeToSec > 82800) {
                        $oldUpper = 86400 - $endTimeToSec;
                    
                        if ($oldUpper < 0) {
                            $oldUpper = $endTimeToSec - 86400;
                        }
                    } else {
                        $oldUpper = $endTimeToSec;
                    }

                    $newDayArray = true;
                } else if ($startTimeToSec > $endTimeToSec) {
                    // Проверяем, начало работы больше, чем завершение
                    // Например: Начало 14:00, Завершение: 01:00
                    // То переносим остаток времени, на следующий календарный день
                    // Необходимо для часовых поясов
                    $oldLower = $startTimeToSec - 86400;
                    
                    if ($oldLower < 0) {
                        $prevDayArray = true;
                        $oldUpper = -3600;
                        $startTimeToSec = 0;
                    } else {
                        $oldUpper = $endTimeToSec;
                        $endTimeToSec = 82800;
                        $newDayArray = true;
                    }
                } else if ($endTimeToSec > 82800) {
                    // Проверяем, если время больше 23:00, то переносим на следующий день
                    $oldUpper = 86400 - $endTimeToSec;
                    
                    if ($oldUpper < 0) {
                        $oldUpper = $endTimeToSec - 86400;
                    }

                    $endTimeToSec = 82800;
                    $newDayArray = true;
                }

                if ($prevDayArray) {
                    $workDateYesterday = date("Y-m-d", strtotime($worktimeItem->dayweek . "-1 day"));

                    if ($workDateYesterday >= date("Y-m-d")) {
                        $rangeNew = hoursRange(
                            $oldLower, 
                            $oldUpper, 
                            60 * 60, 
                            $workDateNew, 
                            $dateArraySch, 
                            $diffTimezoneOffset
                        );
                        $dateArrayNewDay[$workDateYesterday] = $rangeNew;
                    }
                }

                if ($newDayArray) {
                    $workDateNew = date("Y-m-d", strtotime($worktimeItem->dayweek . "+1 day"));
                    $rangeNew = hoursRange(
                        $oldLower, 
                        $oldUpper, 
                        60 * 60, 
                        $workDateNew, 
                        $dateArraySch, 
                        $diffTimezoneOffset
                    );
                    $dateArrayNewDay[$workDateNew] = $rangeNew;
                }

                $range = hoursRange(
                    $startTimeToSec, 
                    $endTimeToSec, 
                    60 * 60, 
                    $workDate, 
                    $dateArraySch, 
                    $diffTimezoneOffset
                );

                $dateArray[$workDate] = $range;
            }
        }
    }

    $newDateArray = [];
    
    // Прогоняем массив с новыми дням, если он есть
    if (!empty($dateArrayNewDay)) {
        foreach ($dateArrayNewDay as $newDateKey => $newDateValue) {
            foreach ($newDateValue as $newDayValue) {
                $newDateArray[$newDateKey][] = $newDayValue;
            }
        }
    }

    foreach ($dateArray as $dateKey => $dateValue) {
        foreach ($dateValue as $dayValue) {
            if (!in_array($dayValue, $newDateArray[$dateKey])) {
                $newDateArray[$dateKey][] = $dayValue;
            }
            sort($newDateArray[$dateKey]);
        }
    }
    
    ksort($newDateArray);
    return $newDateArray;