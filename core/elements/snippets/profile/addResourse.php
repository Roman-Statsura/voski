<?php
require_once MODX_CORE_PATH.'model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');
    
    $file = $_FILES['photo']['tmp_name'];
    var_dump($_POST);

    /*if (!empty($thumb)) {
        $fullPath = $_SERVER['DOCUMENT_ROOT'] . "/assets/images/videos/" . $resource->get('id');
        $fullPathIMG = $fullPath . "/maxpreview.jpg";
        $fullPathIMG_WebP = $fullPath . "/maxpreview.webp";

        if (!is_dir($fullPath)) {
            mkdir($fullPath, 0777);
        }

        $content = file_get_contents($thumb);
        if (!file_exists($fullPathIMG)) {
            file_put_contents($fullPathIMG, $content);
        }

        $resource->setTVValue('videoPreview', '/assets/images/videos/' . $resource->get('id') . '/maxpreview.jpg');
    }


    $newResource = $modx->newObject('modDocument');

    $newResource->set('pagetitle', $item['pagetitle']);
    $newResource->set('content', $item['description']);
    $newResource->set('alias', $item['alias']);
    $newResource->set('published', 1);
    $newResource->set('template', 3);
    $newResource->set('parent', 2);
    $newResource->set('publishedon', $item['publishedon']);
    $newResource->set('menuindex', $item['menuindex']);
    $newResource->save();
    
    $docId = $newResource->get('id');
    $tvs = $modx->getObject('modResource', $docId);
    $tvs->setTVValue('videoSRC', $item['link']);
    $tvs->setTVValue('videoPreview', $item['thumb']);
    
    $tvs->save();*/