<?php
    date_default_timezone_set('UTC');
    $timezone_identifiers = array_merge(DateTimeZone::listIdentifiers(128), DateTimeZone::listIdentifiers(16));
    $timezones = "";
    $tzs = array();
    $locale = "ru_RU.utf8";

    foreach ($timezone_identifiers as $key => $timezone) {
        $dtz = new DateTimeZone($timezone);
        $tz = IntlTimeZone::createTimeZone($timezone);

        if ($tz->getID() === 'Etc/Unknown' || $timezone === 'UTC') {
            $name = $timezone;

            if ($timezone === 'Europe/Saratov') {
                $name = 'Саратов';
            }
        }
        else {
            $name = $tz->getDisplayName(false, 3, $locale);

            if ($name === 'Ulyanovsk') {
                $name = 'Ульяновск';
            } elseif ($name === 'Astrakhan') {
                $name = 'Астрахань';
            }
        }

        // time offset
        $offset = $dtz->getOffset(new DateTime());
        $sign   = ($offset < 0) ? '-' : '+';

        $tzs[$timezone] = [
            'code'   => $timezone,
            'title'  => $name,
            'name'   => '(UTC' . $sign . date('H:i', abs($offset)) . ') ' . $name,
            'offset' => $offset,
        ];
    }

    uasort($tzs, function($a, $b){
        if ($a['offset'] > $b['offset']) {
            return 1;
        }
        elseif ($a['offset'] < $b['offset']) {
            return -1;
        }
        elseif ($a['name'] > $b['name']) {
            return 1;
        }
        elseif ($a['name'] < $b['name']) {
            return -1;
        }
        return 0;
    });

    if ($type == "name") {
        foreach ($tzs as $key => $arr) {
            if (!empty($current)) {
                if ($arr['code'] == $current) {
                    return $arr["title"];
                }
            }
        }
    } else {
        foreach ($tzs as $key => $arr) {
            if (!empty($current)) {
                if ($arr['code'] == $current) {
                    $timezones .= "<option value='{$arr['code']}' selected>{$arr['name']}</option>";
                } else {
                    $timezones .= "<option value='{$arr['code']}'>{$arr['name']}</option>";
                }
            } else {
                $timezones .= "<option value='{$arr['code']}'>{$arr['name']}</option>";
            }
        }

        return $timezones;
    }