<?php
    $tv = $modx->getObject('modTemplateVar', array('id' => $tvid));

    $text = explode('||', $tv->get('elements'));
    $resArray = [];

    foreach ($text as $input) {
        $values = explode('==', $input);
        $resArray[$values[1]] = $values[0];
    }
    $output = "";
    foreach ($resArray as $key => $res) {
        $output .= "<input class='filter__input' id='filter_{$key}' type='checkbox' name='filter' value='{$key}'>
                    <label for='filter_{$key}'>{$res}</label>";
    }

    return $output;