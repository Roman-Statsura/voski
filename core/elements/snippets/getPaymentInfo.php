<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/yookassa/YooKassaIntegration.php';
    $redirectURL = "{$modx->getOption('site_url')}payment-status";

    $response = [];
    $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', $redirectURL);
    $payment = $paymentClass->getPaymentInfo($paymentID);

    if ($payment) {
        if (empty($payment->refunded_amount)) {
            switch ($payment->status) {
                case 'pending':
                    $status = "Ожидает оплаты";
                    break;
                case 'waiting_for_capture':
                    $status = "Оплачен, удержано";
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

            $paymentPrice = $payment->amount->value;
        } else {
            $status = "Отменен, возврат";
            $paymentPrice = $payment->refunded_amount->value;
        }

        $response["statusCode"] = $payment->status;
        $response["status"] = $status;
        $response["price"] = intval($paymentPrice);
        $response["paid"] = $payment->paid;
        $response["description"] = $payment->description;
    }
    return $response;