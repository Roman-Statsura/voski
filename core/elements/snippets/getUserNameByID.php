<?php
    $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = $id";
    $statement = $modx->query($sql);
    $users = $statement->fetchAll(PDO::FETCH_ASSOC);

    foreach ($users as $user) {
        if ($extended) {
            $extended = json_decode($user['extended'], true);
            return $extended[$field];
        } else {
            return $user[$field];
        }
    }