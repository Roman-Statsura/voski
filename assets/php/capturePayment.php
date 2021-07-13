<?php
    /**
     * Скрипт подтверждения платежа.
     * Клиент подтверджает платеж, но деньги удерживаются. За день до консультации, скрипт отправляет
     * запрос в ЮКассу, на то, что платеж подтверждается и сумма списывается со счета клиента.
     * 
     * Настраивается по cron, примерно на каждый час
     **/
    require_once '../../core/model/modx/modx.class.php';
    require_once './yookassa/YooKassaIntegration.php';

    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    // Получаем список всех консультации
    $params = array(
        'parents' => 36,
        'sortby' => 'publishedon',
        'sortdir' => 'DESC',
        'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
                         consultDesc, consultStatusSession, consultDuration, consultSended, consultPaymentID',
        'includeContent' => '1',
        'return' => 'json',
        'limit' => 0
	);

	$consultationResources = json_decode($modx->runSnippet('pdoResources', $params), true);
    $redirectURL = "{$modx->getOption('site_url')}payment-status";

    foreach ($consultationResources as $consultRes) {
        // Отбираем все консультации, где имеется id платежа
        if (!empty($consultRes["tv.consultPaymentID"])) {
            $currentDatetime = time();
            $consultDatetime = strtotime("-1 day", strtotime($consultRes["tv.consultDatetime"]));

            // Смотрим только те консультации, до начала которых осталось менее дня
            if ($currentDatetime >= $consultDatetime) {
                $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', $redirectURL);
                $paymentID = $consultRes["tv.consultPaymentID"];
                $paymentInfo = $paymentClass->getPaymentInfo($paymentID); // Получаем информацию платежа с ЮКассы

                if ($paymentInfo) {
                    $paymentPrice = $paymentInfo->amount->value;
                    $capturePayment = $paymentClass->capturePayment($paymentID, $paymentPrice); // Отправляем запрос на подтверждение платежа

                    if ($capturePayment) {
                        echo "Captured payment succeeded approved";
                        return $capturePayment;
                    } else {
                        echo "Something Wrong!";
                        return false;
                    }
                }
            }
        }
    }