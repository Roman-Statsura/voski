<?php
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    $premoderateSetting = $modx->getOption('Profile.Premoderation');

    $result = [
        'state' => '',
        'message' => ''
    ];

    $idUser = $modx->findResource('tarot-readers/id' . $_POST['idUser'], 'web');

    if ($idUser) {
        $resource = $modx->getObject('modResource', $idUser);
        $resourceID = $resource->get('id');
        $photoMIGX = $resource->getTVValue('photo');
        $certsMIGX = $resource->getTVValue('certs');

        $file = $_FILES['photo']['tmp_name'];
        $certs = $_FILES['certs']['tmp_name'];

        $certsArray = [];

        if ($premoderateSetting) {
            $resource->setTVValue('fio-pre', $_POST['fullname']);
            $resource->setTVValue('content-pre', $_POST['about']);

            $resource->setTVValue('city-pre', $_POST['city']);
            $resource->setTVValue('experience-pre', $_POST['experience']);
            $resource->setTVValue('price-pre', $_POST['price']);
            $resource->setTVValue('specialization-pre', $_POST['specialization']);
            $resource->setTVValue('gender-pre', $_POST['gender']);
            $resource->setTVValue('isModerate', '1');
        } else {
            $resource->setTVValue('pagetitle', $_POST['fullname']);
            $resource->setTVValue('content', $_POST['about']);

            $resource->setTVValue('city', $_POST['city']);
            $resource->setTVValue('experience', $_POST['experience']);
            $resource->setTVValue('price', $_POST['price']);
            $resource->setTVValue('specialization', $_POST['specialization']);
            $resource->setTVValue('gender', $_POST['gender']);
            $resource->setTVValue('isModerate', '0');
        }
        
        if (!empty($file)) {
            $filename = "maxpreview";
            $fullPath = $_SERVER['DOCUMENT_ROOT'] . "/assets/img/tarolog/" . $resourceID;
            $filename .= "-" . $key . "-" . date("Ymd-his");
            $fullPathIMG = $fullPath . "/" . $filename . ".jpg";
            $pathIMG = "/assets/img/tarolog/" . $resourceID . "/" . $filename . ".jpg";
            
            if (!is_dir($fullPath)) {
                mkdir($fullPath, 0777);
            }

            if (!file_exists($fullPathIMG)) {
                if (move_uploaded_file($file, $fullPathIMG)) {
                    if ($premoderateSetting) {
                        $resource->setTVValue('photo-pre', $pathIMG);
                    } else {
                        $resource->setTVValue('photo', $pathIMG);
                    }
                } else {
                    $result = [
                        'state' => 'error',
                        'message' => 'Проблемы с загрузкой фото.'
                    ];
                    $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с загрузкой фото.');
                }

            }
        }

        if ($certs && !empty($certs[0])) {
            $certsArray = json_decode($_POST['uploaded-certs']);
            $newCleanArray = [];
            foreach ($certsArray as $key => $elem) {
                if ($elem != "") {
                    $newCleanArray[] = $elem;
                }
            }
            $i = count($newCleanArray);

            foreach ($certs as $key => $cert) {
                $filename = "maxpreview";
                $fullPath = $_SERVER['DOCUMENT_ROOT'] . "/assets/img/tarolog/" . $resourceID . "/certs";

                if (!is_dir($fullPath)) {
                    mkdir($fullPath, 0777);
                }

                $filename .= "-" . $key . "-" . date("Ymd-his");
                $fullPathIMG = $fullPath . "/" . $filename . ".jpg";
                $pathIMG = "/assets/img/tarolog/" . $resourceID . "/certs/" . $filename . ".jpg";

                if (move_uploaded_file($cert, $fullPathIMG)) {
                    $newCleanArray[] = [
                        'MIGX_id' => $i + 1,
                        'photo' => $pathIMG,
                        'thumbnail' => '',
                        'alt' => '',
                        'active' => 1
                    ];
                    $i++;
                } else {
                    $result = [
                        'state' => 'error',
                        'message' => 'Проблемы с загрузкой фото.'
                    ];
                    $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с загрузкой фото.');
                }
            }

            if ($premoderateSetting) {
                $resource->setTVValue('certs-pre', json_encode($newCleanArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
            } else {
                $resource->setTVValue('certs', json_encode($newCleanArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
            }
        } else {
            if (!empty($_POST['uploaded-certs'])) {
                $certsArray = json_decode($_POST['uploaded-certs']);
                $newCleanArray = [];
                foreach ($certsArray as $key => $elem) {
                    if ($elem != "") {
                        $newCleanArray[] = $elem;
                    }
                }
                $certsArray = json_encode($newCleanArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
                
                if ($premoderateSetting) {
                    $resource->setTVValue('certs-pre', $certsArray);
                } else {
                    $resource->setTVValue('certs', $certsArray);
                }
            }
        }

        if (!$resource->save()) {
            $result = [
                'state' => 'info',
                'message' => 'Ошибка сохранения анкеты!'
            ];
        } else {
            $result = [
                'state' => 'info',
                'message' => 'Анкета отправлена на модерацию'
            ];
        }
    } else {
        $certsArray = [];
        
        $file = $_FILES['photo']['tmp_name'];
        $certs = $_FILES['certs']['tmp_name'];

        $newResource = $modx->newObject('modDocument');

        $newResource->set('pagetitle', $_POST['fullname']);
        $newResource->set('content', $_POST['about']);
        $newResource->set('alias', 'id' . $_POST['idUser']);
        $newResource->set('class_key', 'CollectionContainer');
        $newResource->set('published', 0);
        $newResource->set('template', 16);
        $newResource->set('parent', 2);
        $newResource->set('cacheable', 0);
        $newResource->set('publishedon', time());

        if (!$newResource->save()) {
            $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с сохранением ресурса. ID ресурса - ' . $newResource->get('id'));
            $result = [
                'state' => 'error',
                'message' => 'Проблемы с сохранением ресурса.'
            ];
        } else {
            $newTarolog = $newResource->get('id');
            $tvs = $modx->getObject('modResource', $newTarolog);
            $tvs->setTVValue('idUser', $_POST['idUser']);
            $tvs->setTVValue('city', $_POST['city']);
            $tvs->setTVValue('experience', $_POST['experience']);
            $tvs->setTVValue('price', $_POST['price']);
            $tvs->setTVValue('gender', $_POST['gender']);
            $tvs->setTVValue('specialization', $_POST['specialization']);

            $resource->setTVValue('fio-pre', $_POST['fullname']);
            $resource->setTVValue('content-pre', $_POST['about']);
            $resource->setTVValue('city-pre', $_POST['city']);
            $resource->setTVValue('experience-pre', $_POST['experience']);
            $resource->setTVValue('price-pre', $_POST['price']);
            $resource->setTVValue('specialization-pre', $_POST['specialization']);
            $resource->setTVValue('gender-pre', $_POST['gender']);
            $resource->setTVValue('isModerate', '1');

            if (!empty($file)) {
                $fullPath = $_SERVER['DOCUMENT_ROOT'] . "/assets/img/tarolog/" . $newTarolog;
                $fullPathIMG = $fullPath . "/maxpreview.jpg";
                $pathIMG = "/assets/img/tarolog/" . $newTarolog . "/maxpreview.jpg";

                if (!is_dir($fullPath)) {
                    mkdir($fullPath, 0777);
                }

                if (!file_exists($fullPathIMG)) {
                    if (move_uploaded_file($file, $fullPathIMG)) {
                        if ($premoderateSetting) {
                            $resource->setTVValue('photo-pre', $pathIMG);
                        } else {
                            $resource->setTVValue('photo', $pathIMG);
                        }
                    } else {
                        $result = [
                            'state' => 'error',
                            'message' => 'Проблемы с загрузкой фото.'
                        ];
                        $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с загрузкой фото.');
                    }

                }
            }

            if (!empty($certs)) {
                $i = 0;

                foreach ($certs as $key => $cert) {
                    $filename = "maxpreview";
                    $fullPath = $_SERVER['DOCUMENT_ROOT'] . "/assets/img/tarolog/" . $newTarolog . "/certs";
                    $fullPathIMG = $fullPath . "/" . $filename . ".jpg";
                    $pathIMG = "/assets/img/tarolog/" . $newTarolog . "/certs/" . $filename . ".jpg";

                    if (!is_dir($fullPath)) {
                        mkdir($fullPath, 0777);
                    }

                    if (!file_exists($fullPathIMG)) {
                        if (move_uploaded_file($cert, $fullPathIMG)) {
                            $certsArray[] = [
                                'MIGX_id' => $i,
                                'photo' => $pathIMG,
                                'thumbnail' => '',
                                'alt' => '',
                                'active' => 1
                            ];
                            $i++;
                        } else {
                            $result = [
                                'state' => 'error',
                                'message' => 'Проблемы с загрузкой фото.'
                            ];
                            $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с загрузкой фото.');
                        }
                    } else {
                        $filename .= "-" . $key . "-" . date("Ymd-his");
                        $fullPathIMG = $fullPath . "/" . $filename . ".jpg";
                        $pathIMG = "/assets/img/tarolog/" . $newTarolog . "/certs/" . $filename . ".jpg";

                        if (move_uploaded_file($cert, $fullPathIMG)) {
                            $certsArray[] = [
                                'MIGX_id' => $i,
                                'photo' => $pathIMG,
                                'thumbnail' => '',
                                'alt' => '',
                                'active' => 1
                            ];
                            $i++;
                        } else {
                            $result = [
                                'state' => 'error',
                                'message' => 'Проблемы с загрузкой фото.'
                            ];
                            $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с загрузкой фото.');
                        }
                    }
                }

                // $tvs->setTVValue('certs', json_encode($certsArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));

                if ($premoderateSetting) {
                    $tvs->setTVValue('certs-pre', json_encode($certsArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
                } else {
                    $tvs->setTVValue('certs', json_encode($certsArray, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES));
                }
            }
            
            if (!$tvs->save()) {
                $result = [
                    'state' => 'error',
                    'message' => 'Проблемы с сохранением доп полей ресурса.'
                ];
                
                $modx->log(xPDO::LOG_LEVEL_ERROR, 'Проблемы с сохранением доп полей ресурса. ID ресурса - ' . $newTarolog);
            } else {
                $result = [
                    'state' => 'info',
                    'message' => 'Анкета отправлена на модерацию'
                ];
            }
        }
    }
    
    echo json_encode($result, JSON_UNESCAPED_UNICODE);