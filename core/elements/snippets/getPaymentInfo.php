<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/yookassa/YooKassaIntegration.php';
    $redirectURL = "{$modx->getOption('site_url')}payment-status";

    $response = [];
    $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', $redirectURL);
    $payment = $paymentClass->getPaymentInfo($paymentID);

    if ($payment) {
        switch ($payment->status) {
            case 'pending':
                $status = "Ожидает оплаты";
                break;
            case 'waiting_for_capture':
                $status = "Оплачен";
                break;
            case 'succeeded':
                $status = "Оплачен";
                break;
            case 'canceled':
                $status = "Отменен";
                break;
            default:
                $status = "Ожидает оплаты";
                break;
        }

        $response["statusCode"] = $payment->status;
        $response["status"] = $status;
        $response["price"] = intval($payment->amount->value);
        $response["paid"] = $payment->paid;
        $response["description"] = $payment->description;
    }
    return $response;