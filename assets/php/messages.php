<?php
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $resource = $modx->getObject('modResource', 1);
    $resourceID = $resource->get('id');
    $messagesMIGX = $resource->getTVValue('messages');

    $msgCurrentArray = json_decode($messagesMIGX);

    foreach($msgCurrentArray as $msgCurrentItem) {
        $msgNewArray = [];

        $msgNewSubArray = [];
        $msgNewSubArray["MIGX_id"] = end($msgAnswersArray)->MIGX_id + 1;
        $msgNewSubArray["date"] = date("Y-m-d H:i:s");
        $msgNewSubArray["idUser"] = $_POST['idUser'];
        $msgNewSubArray["text"] = $_POST['msgText'];
        $msgNewSubArray["active"] = '1';

        $msgNewArray[] = $msgNewSubArray;

        if (!empty($msgCurrentItem->answers)) {
            $msgCurrentItem->answers[] = $msgNewSubArray;
        } else {
            $msgCurrentItem->answers = $msgNewArray;
        }
    }

    $resource->setTVValue('messages', json_encode($msgCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

    if (!$resource->save()) {
        $result = [
            'state' => 'info',
            'message' => 'Ошибка оправки сообщения!'
        ];
    } else {
        $result = [
            'state' => 'info',
            'message' => 'Сообщение успешно отправлено'
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE);