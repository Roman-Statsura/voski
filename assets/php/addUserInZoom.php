<?php
    require_once '../../core/model/modx/modx.class.php';
    require_once './zoomJWT/jwtTokenGenerator.php';
    require_once './sendMail.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    if (isset($_GET["action"]) && $_GET["action"] == "sendZoomInvite") {
        //$jwt = new JWT("MKiwFG0fRCy09jlSdC4eJw", "7p36DPYZ85dLHoKOMs14mH10PCnzZEzyrLET");
        $jwt = new JWT("8hZhpGokSciGWCsmKCOooA", "y56UyoD64fhHxX9YhBJjP3T9bK7GV8Tw", "eGxKJY2USMWeRrduNF5Cpg", "OAuth");
        $jwtToken = $jwt->OAuthTokenGenerate();

        $sql = "SELECT * FROM `modx_user_attributes` WHERE `internalKey` = " . $_GET['tarotID'];
        $statement = $modx->query($sql);
        $users = $statement->fetchAll(PDO::FETCH_ASSOC);
        $tarotName = "";
        $tarotEmail = "";

        foreach ($users as $user) {
            $tarotName = $user["fullname"];
            $tarotEmail = $user["email"];
        }

        $idTarotUser = $modx->findResource('tarot-readers/id' . $_GET['tarotID'], 'web');
        $resource = $modx->getObject('modResource', $idTarotUser);

        if ($resource) {
            $query = array(
                "action" => "create",
                "user_info" => array(
                    "email" => $tarotEmail,
                    "type" => 1,
                    "first_name" => $tarotName
                )
            );

            $createZoomUser = $jwt->cURLQueries("https://api.zoom.us/v2/users", $jwtToken, $query, "POST");
            $createZoomUser = json_decode($createZoomUser);

            if (!$createZoomUser) {
                echo "Something Wrong!";
            } else {
                $resource->setTVValue('statusInviteZoom', 2);
                echo "Приглашение успешно отправлено тарологу! Закройте данную вкладку!";
            }
        }
    } else {
        $properties = [
            "tarotID"       => $_POST["tarotID"],
            "questTarotID"  => $_POST["questTarotID"],
            "tarotName"     => $_POST["tarotName"],
            "tarotEmail"    => $_POST["tarotEmail"]
        ];

        $resource = $modx->getObject('modResource', $_POST["questTarotID"]);
        if ($resource) {
            if (sendMail($modx, $modx->getOption('emailsender'), "Заявка на добавление в аккаунт Zoom", 'addUserInZoomNotify', $properties)) {
                $resource->setTVValue('statusInviteZoom', 1);
                echo "success!";
            } else {
                $modx->log(xPDO::LOG_LEVEL_ERROR, "Error Send Email! Tarot ID: {$_POST["questTarotID"]}, Email: {$_POST["tarotEmail"]}.");
            }
        }
    }