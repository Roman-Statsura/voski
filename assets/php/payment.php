<?php
    /**
     * YooKassaIntegration Class Test
     * Test Shop Voski
     */
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    require_once './yookassa/YooKassaIntegration.php';

    $user_id = $_POST["idUser"];

    // Testing
    $paymentClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', "http://voski.loc/payment-status");

    if (!empty($_POST["cardname"]) && !empty($_POST["creditnumber"]) && !empty($_POST["datefinished"]) && !empty($_POST["cvc"])) {
        $dateFinished = explode("/", $_POST["datefinished"]);
        $dateMonth = DateTime::createFromFormat('m', $dateFinished[0]);
        $dateYear = DateTime::createFromFormat('y', $dateFinished[1]);

        $paymentCard = [
            "type" => "bank_card",
            "card" => [
                "cardholder" => $_POST["cardname"],
                "number" => str_replace(" ", "", $_POST["creditnumber"]),
                "expiry_month" => $dateFinished[0],
                "expiry_year" => $dateYear->format('Y'),
                "csc" => $_POST["cvc"]
            ]
        ];
    }

    switch ($_GET["type"]) {
        case "checkNewCard":
            $subjectTitle = "Проверка актуальности карты для привязки";
            $price = 1.0;
            break;
        default:
            $subjectTitle = "Тестовый заказ";
            $price = 100.0;
            break;
    }

    switch ($_GET["action"]) {
        case "createPayment":
            $payment = $paymentClass->createPayment($subjectTitle, $price, $paymentCard, true);
            echo json_encode($payment, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
            break;
        case "capturePayment":
            $payment = $paymentClass->capturePayment("2874e23a-000f-5000-8000-1dbf854bc854", 100.0);
            break;
        case "cancelPayment":
            $payment = $paymentClass->cancelPayment("2874e23a-000f-5000-8000-1dbf854bc854");
            break;
        case "createRefund":
            $payment = $paymentClass->createRefund($_POST["paymentID"], 1.0);
            break;
        case "getPaymentInfo":
            $payment = $paymentClass->getPaymentInfo($_GET["paymentID"]);
            echo $payment;
            break;
        default:
            $payment = "Nothing";
            break;
    }