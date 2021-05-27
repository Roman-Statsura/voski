<?php
    switch ($sessionID) {
        case 0:
            $sessionName = "В ожидании";
            break;
        case 1:
            $sessionName = "Проведен";
            break;
        case 2:
            $sessionName = "Отменен";
            break;
        case 3:
            $sessionName = "Закрыт";
            break;
        case 4:
            $sessionName = "Проводится";
            break;
        default:
            $sessionName = "В ожидании";
    }

    return $sessionName;