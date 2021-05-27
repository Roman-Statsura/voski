<?php
    $user = $modx->getObject('modUser', array('username' => '+7 (800) 555-35-35'));

    if (!is_object($user)) {
        var_dump($user);
    } else {
        var_dump("132"); 
    }