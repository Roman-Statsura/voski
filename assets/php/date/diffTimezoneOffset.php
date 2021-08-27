<?php
    function getDiffTimezoneOffset($modx, $idUser) {
        // UTC DateTimeZone
        date_default_timezone_set('UTC');
        $timezone_identifiers = array_merge(DateTimeZone::listIdentifiers(128), DateTimeZone::listIdentifiers(16));
        $timezones = "";
        $tzs = array();

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

        // Получаем информацию клиента
        if ($user = $modx->getObject('modUser', $idUser)) {
            if ($profile = $user->getOne('Profile')) {
                $extended = $profile->get('extended');
                $clientTimezone = $extended["timezone"];
                $userTimezoneCode   = $tzs[$clientTimezone]["code"];
                $userTimezoneOffset = $tzs[$clientTimezone]["offset"];
            }
        }

        // Устанавливаем часовой пояс на Пользовательский
        $defaultTimezone = !$userTimezoneCode ? "Europe/Moscow" : $userTimezoneCode;
        if (date_default_timezone_get() != $defaultTimezone) {
            date_default_timezone_set($defaultTimezone);
        }

        if (date_default_timezone_get() != "Europe/Moscow") {
            $dateTimeZoneMoscow = new DateTimeZone("Europe/Moscow");
            $dateTimeMoscow = new DateTime("now", $dateTimeZoneMoscow);
            $moscowTimezoneOffset = $dateTimeZoneMoscow->getOffset($dateTimeMoscow);

            // Получаем разницу между указанным часовым поясом клиента и Москвой
            $diffTimezoneOffset = $userTimezoneOffset - $moscowTimezoneOffset;
        } else {
            $diffTimezoneOffset = 0;
        }

        return $diffTimezoneOffset;
    }