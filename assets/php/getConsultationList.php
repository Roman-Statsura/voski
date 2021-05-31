<?php
    require_once '../../core/model/modx/modx.class.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $params = array(
        'parents' => 36,
        'sortby' => 'consultDatetime',
        'sortdir' => 'ASC',
        'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
                         consultDesc, consultStatusSession, consultDuration, consultSended',
        'includeContent' => '1',
        'return' => 'json',
        'limit' => 0
	);

	echo $modx->runSnippet('pdoResources', $params);