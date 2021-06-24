<?php
    /**
     * YooKassaIntegration Class Test
     * Test Shop Voski
     */
    use YooKassa\Client;

    require dirname(__DIR__) . '/../../vendor/autoload.php';

    class YooKassaIntegration {
        protected $client;
        public $returnURL;
    
        public function __construct($shopid, $secretKey, $returnURL) {
            $this->client = new Client();
            $this->returnURL = $returnURL;

            // connection
            $this->client->setAuth($shopid, $secretKey);
        }

        /**
         * Create Payment
         *
         * @param [string] $name
         * @param [float] $value
         * @return String confirmation_url (3-D Secure Link)
         */
        public function createPayment($name, $value, $paymentMethodData = []) {
            $request = [
                'amount' => [
                    'value' => $value,
                    'currency' => 'RUB',
                ],
                'confirmation' => [
                    'type' => 'redirect',
                    'return_url' => $this->returnURL,
                ],
                'capture' => true,
                'description' => $name,
            ];

            if ($paymentMethodData) {
                $request["payment_method_data"] = $paymentMethodData;
            }
            
            $payment = $this->client->createPayment($request, uniqid('', true));

            return $payment->confirmation->confirmation_url;
        }
    }