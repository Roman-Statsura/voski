<?php
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $result = [
        'state' => '',
        'message' => ''
    ];

    $getIDClient = $_POST['getIDClient'];
    $idTarot = $_POST["idTarot"];
    $idClient = $_POST['idClient'];
    $rating = (int)$_POST['rating'];
    $desc = $_POST['desc'];
    $idConsult = $_POST['idConsult'];

    $resource = $modx->getObject('modResource', $idTarot);
    $tarotRatingMIGX = $resource->getTVValue('rating');
    $redirect = false;

    function addRating($resource, $idClient, $rating, $desc, $idConsult) {
        if ($rating > 0) {
            $ratingNewArray = [];
            $ratingNewArray["MIGX_id"] = end($ratingCurrentArray)->MIGX_id + 1;
            $ratingNewArray["idClient"] = $idClient;
            $ratingNewArray["rating"] = $rating;
            $ratingNewArray["desc"] = $desc;
            $ratingNewArray["idConsult"] = $idConsult;
            $ratingNewArray["active"] = 1;

            $ratingCurrentArray[] = $ratingNewArray;
            $resource->setTVValue('rating', json_encode($ratingCurrentArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

            $result = [
                'state' => "success",
                'message' => "Оценка поставлена! Спасибо за ваш отзыв!<br>Можете закрыть окно."
            ];
        } else {
            $result = [
                'state' => "error",
                'message' => "Поставьте пожалуйста Вашу оценку"
            ];
        }

        return $result;
    }

    if (!empty($tarotRatingMIGX)) {
        $ratingCurrentArray = json_decode($tarotRatingMIGX);
        
        foreach ($ratingCurrentArray as $key => $value) {
            if ($value->idClient == $getIDClient && 
                $value->idConsult == $idConsult) {
                $redirect = true;
            }
        }

        if ($redirect) {
            $result = [
                'state' => 'error',
                'message' => 'Вы уже проголосовали!'
            ];
        } else {
            $result = addRating($resource, $idClient, $rating, $desc, $idConsult);
        }
    } else {
        $result = addRating($resource, $idClient, $rating, $desc, $idConsult);
    }

    if (!$resource->save()) {
        $result = [
            'state' => 'error',
            'message' => 'Ошибка сохранения вашей оценки! Повторите еще раз!'
        ];
    }

    echo json_encode($result, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);