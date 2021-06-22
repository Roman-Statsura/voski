<?php
    $resource = $modx->getObject('modResource', $idTarot);
    $tarotRatingMIGX = $resource->getTVValue('rating');
    $tarotRatingMIGXArray = json_decode($tarotRatingMIGX);

    if (!empty($tarotRatingMIGXArray)) {
        $sumRating = 0;

        foreach ($tarotRatingMIGXArray as $ratingItem) {
            $sumRating += $ratingItem->rating;
        }

        return $sumRating / count($tarotRatingMIGXArray);
    }