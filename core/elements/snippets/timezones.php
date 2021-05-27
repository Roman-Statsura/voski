<?php
    date_default_timezone_set('UTC');
    $timezone_identifiers = DateTimeZone::listIdentifiers(128);
    $timezones = "";
    $tzs = array();

    foreach ($timezone_identifiers as $key => $timezone) {
        $dtz = new DateTimeZone($timezone);
        $tz = IntlTimeZone::createTimeZone($timezone);

        if ($tz->getID() === 'Etc/Unknown' or $timezone === 'UTC') $name = $timezone;
        else $name = $tz->getDisplayName(false, 3, $locale);
        // time offset
        $offset = $dtz->getOffset(new DateTime());
        $sign   = ($offset < 0) ? '-' : '+';

        array_push($tzs, [
            'code'   => $timezone,
            'name'   => '(UTC' . $sign . date('H:i', abs($offset)) . ') ' . $name,
            'offset' => $offset,
        ]);
    }

    $sortedArray = krsort($tzs);
    foreach ($tzs as $key => $arr) {
        if (!empty($current)) {
            if ($key == $current) {
                $timezones .= "<option value='{$key}' selected>{$arr['name']}</option>";
            } else {
                $timezones .= "<option value='{$key}'>{$arr['name']}</option>";
            }
        } else {
            $timezones .= "<option value='{$key}'>{$arr['name']}</option>";
        }
    }

    return $timezones;