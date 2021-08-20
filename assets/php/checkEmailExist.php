<?php
    require_once '../../core/model/modx/modx.class.php';
    
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $email = $_POST["email"];
    $emailTaken = $modx->getObject('modUserProfile', array('email' => $email));
    $taken = "false";

    if ($emailTaken) {
        $taken = "true";
    }
    
    echo $taken;