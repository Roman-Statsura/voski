<?php
$params = array(
        'parents' => 36,
        'sortby' => 'publishedon',
        'sortdir' => 'DESC',
        'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
                         consultDesc, consultStatusSession, consultDuration, consultSended',
        'includeContent' => '1',
        'return' => 'json',
        'limit' => 0
	);

	return $modx->runSnippet('pdoResources', $params);