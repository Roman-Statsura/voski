<?php
if ($modx->event->name == 'OnDocFormSave') {
    $resourceID = $resource->get('id');
    $premoderateSetting = $modx->getOption('Profile.Premoderation');

    $premoderateFields = [
        "pagetitle" => [
            "title" => "fio-pre",
            "type" => "field",
        ],
        "content" => [
            "title" => "content-pre",
            "type" => "field",
        ],
        "city" => [
            "title" => "city-pre",
            "type" => "tv",
        ],
        "experience" => [
            "title" => "experience-pre",
            "type" => "tv",
        ],
        "price" => [
            "title" => "price-pre",
            "type" => "tv",
        ],
        "specialization" => [
            "title" => "specialization-pre",
            "type" => "tv",
        ],
        "gender" => [
            "title" => "gender-pre",
            "type" => "tv",
        ],
        "photo" => [
            "title" => "photo-pre",
            "type" => "tv",
        ],
        "certs" => [
            "title" => "certs-pre",
            "type" => "tv",
        ]
    ];

    if ($resourceID) {
        if ($premoderateSetting) {
            foreach ($premoderateFields as $preKey => $preField) {
                if (!empty($resource->getTVValue($preField["title"]))) {
                    if ($preField["type"] == "tv") {
                        $resource->setTVValue($preKey, $resource->getTVValue($preField["title"]));
                    } else {
                        $resource->set($preKey, $resource->getTVValue($preField["title"]));
                    }
                }
            }

            $resource->setTVValue("isModerate", "0");

            if (!$resource->save()) {
                $modx->log(xPDO::LOG_LEVEL_ERROR, 'Ошибка с сохранением ресурсов');
            }
        }
    }
}