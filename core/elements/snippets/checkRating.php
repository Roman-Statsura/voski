<?php
$resource = $modx->getObject('modResource', $idTarot);
    $tarotRatingMIGX = $resource->getTVValue('rating');
    $redirect = 'false';

    if ($tarotRatingMIGX) {
        $ratingCurrentArray = json_decode($tarotRatingMIGX);
        
        foreach ($ratingCurrentArray as $key => $value) {
            if ($value->idClient == $getIDClient && 
                $value->idConsult == $idConsult) {
                $redirect = 'true';
            }
        }
    }

    return $redirect;