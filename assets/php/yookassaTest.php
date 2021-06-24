<?php
    /**
     * YooKassaIntegration Class Test
     * Test Shop Voski
     */
    require_once './yookassa/YooKassaIntegration.php';

    // Testing
    $testClass = new YooKassaIntegration('816161', 'test_3wczMGG3w0zovqkXHxCIh6PVkMwYUaaK1JcIIJek4EE', "https://voski.ykdev.ru/return_url");
    $testCard = [
        "type" => "bank_card",
        "card" => [
            "cardholder" => 'MR CARDHOLDER',
            "number" => '5555555555554477',
            "expiry_month" => '01',
            "expiry_year" => '2023',
            "csc" => '213'
        ]
    ];

    $payment = $testClass->createPayment("Тестовый заказ", 100.0, $testCard);
    var_dump($payment);