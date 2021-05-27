<?php
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    if (!empty($_POST['id']) && $_POST['id'] != null) {
        $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $_POST['id'];
        $statement = $modx->query($sql);
        $users = $statement->fetchAll(PDO::FETCH_ASSOC);

        foreach ($users as $user) {
            echo $user[$_POST['field']];
        }
    }