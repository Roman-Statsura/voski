<?php
    if ($modx->user->isAuthenticated() == $isAuth && (!isset($_GET['action']) || $_GET['action'] != 'logout')) {
        $url = $modx->makeUrl($id);
        $modx->sendRedirect($url,array('responseCode' => 'HTTP/1.1 301 Moved Permanently'));
    } else {
        $url = $modx->makeUrl($id);
        $modx->sendRedirect($url,array('responseCode' => 'HTTP/1.1 301 Moved Permanently'));
    }