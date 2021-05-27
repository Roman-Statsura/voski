<?php
    if (!empty($field)) {
        if (isset($_GET[$field]) && !empty($_GET[$field])) {
            $idGameMODX = $modx->findResource('games/'.str_replace(array('---', '--', '_'), '-', $_GET[$field]), 'web');

            return $idGameMODX;
        }
    }