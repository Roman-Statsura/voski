<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/zoomJWT/jwtTokenGenerator.php';

    //$jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
    $jwt = new JWT("8hZhpGokSciGWCsmKCOooA", "y56UyoD64fhHxX9YhBJjP3T9bK7GV8Tw", "eGxKJY2USMWeRrduNF5Cpg", "OAuth");
    $jwtToken = $jwt->OAuthTokenGenerate();

    $resource = $modx->getObject('modResource', $currentUser);
    if ($resource) {
        $statusInviteZoom = $resource->getTVValue('statusInviteZoom');
        $zoomID = $resource->getTVValue('zoomID');

        if (empty($zoomID)) {
            $activeZoomUser = $jwt->cURLQueries("https://api.zoom.us/v2/users/{$currentEmail}", $jwtToken, false, "GET");
            $activeZoomUser = json_decode($activeZoomUser);

            if ($activeZoomUser->id) {
                if ($activeZoomUser->status == "active") {
                    if ($statusInviteZoom == 2) {
                        $resource->setTVValue('statusInviteZoom', 3);
                    }
                    $resource->setTVValue('zoomID', $activeZoomUser->id);
                    return $activeZoomUser->id;
                } elseif ($activeZoomUser->status == "pending") {
                    if ($statusInviteZoom == 1) {
                        $resource->setTVValue('statusInviteZoom', 2);
                    }
                    return "pending";
                }
            } else {
                if ($statusInviteZoom == 1) {
                    return "sendRequest";
                } else {
                    $resource->setTVValue('statusInviteZoom', 0);
                    return false;
                }
            }
        } else {
            return $zoomID;
        }
    }