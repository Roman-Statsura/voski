<?php
    $sql= "SELECT * FROM `modx_users` ORDER BY id DESC LIMIT 1 ";
    $statement = $modx->query($sql);
    $users = $statement->fetchAll(PDO::FETCH_ASSOC);
    foreach ($users as $user) {
        return (int)$user['id'] + 1;
    }
    