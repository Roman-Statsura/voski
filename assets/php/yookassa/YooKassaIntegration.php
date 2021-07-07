<?php
    /**
     * YooKassaIntegration Class Test
     * Test Shop Voski
     */
    use YooKassa\Client;
    require_once 'Luhn.php';
    require dirname(__DIR__) . '/../../vendor/autoload.php';

    class YooKassaIntegration {
        protected $client;
        public $returnURL;
    
        public function __construct($shopid, $secretKey, $returnURL) {
            $this->client = new Client();
            $this->returnURL = $returnURL;

            // Коннектимся к ЮКассе
            $this->client->setAuth($shopid, $secretKey);
        }

        /**
         * Создание платежа
         *
         * @param [string] $name
         * @param [float] $value
         * @param [array] $paymentMethodData (Информация держателя карты)
         * @param [bool] $capture (Удержание оплаты)
         * @return String confirmation_url (3-D Secure Link)
         */
        public function createPayment($name, $value, $paymentMethodData = [], $capture = true) {
            // Проверяем валидность карты по Luhn Algorithm
            $luhn = new Luhn();
            $vnumber = $paymentMethodData["card"]["number"];

            if ($luhn->validate(substr($vnumber, 0, -1), substr($vnumber, -1, 1)) == true) {
                $vresult = true;
            } else {
                $vresult = false;
            }

            if ($vresult) {
                $request = [
                    'amount' => [
                        'value' => $value,
                        'currency' => 'RUB',
                    ],
                    'confirmation' => [
                        'type' => 'redirect',
                        'return_url' => $this->returnURL,
                    ],
                    'capture' => $capture,
                    'description' => $name,
                ];

                if ($paymentMethodData) {
                    $request["payment_method_data"] = $paymentMethodData;
                }
                
                $payment = $this->client->createPayment($request, uniqid('', true));

                return $payment;
            } else {
                return false;
            }
        }

        /**
         * Подтверждение платежа
         *
         * @param [string] $paymentId
         * @return Object $response
         */
        public function capturePayment($paymentId) {
            $response = $this->client->capturePayment(
                [], 
                $paymentId, 
                uniqid('', true)
            );
            return $response;
        }

        /**
         * Отмена платежа
         *
         * @param [string] $paymentId
         * @return Object $response
         */
        public function cancelPayment($paymentId) {
            $response = $this->client->cancelPayment(
                $paymentId,
                uniqid('', true)
            );
            return $response;
        }

        /**
         * Создание возврата
         * (при условии, что оплата прошла)
         *
         * @param [string] $paymentId
         * @param [float] $value
         * @return Object $response
         */
        public function createRefund($paymentId, $value) {
            $response = $this->client->createRefund(
                array(
                    'payment_id' => $paymentId,
                    'amount' => array(
                        'value' => $value,
                        'currency' => 'RUB',
                    ),
                ),
                uniqid('', true)
            );

            return $response;
        }

        /**
         * Информация об оплате
         *
         * @param [string] $paymentId
         * @return Object $response
         */
        public function getPaymentInfo($paymentId) {
            $response = $this->client->getPaymentInfo($paymentId);
            return $response;
        }

        
        /**
         * Список чеков
         *
         * @return Object $response
         */
        public function getReceipts() {
            $response = $this->client->getReceipts();
            return $response;
        }
    }