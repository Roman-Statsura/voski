<?php
    var_dump($modx->user->isAuthenticated() == $isAuth);
    var_dump(!isset($_GET['action']));
    if ($modx->user->isAuthenticated() == $isAuth && (!isset($_GET['action']) || $_GET['action'] != 'logout')) {
        $url = $modx->makeUrl($id);
        $modx->sendRedirect($url,array('responseCode' => 'HTTP/1.1 301 Moved Permanently'));
    }