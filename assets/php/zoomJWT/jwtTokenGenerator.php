<?php
    //JWT Token Generator
    class JWT {
        private $authType = "OAuth";

        private $header = [
            "alg" => "HS256",
            "typ" => "JWT"
        ];
        
        private $payload = [
            "iss" => "",
            "exp" => ""
        ];

        private $OAuthAccountID = "";
        private $OAuthClient = "";
        private $secret = "";

        public function __construct($API_KEY, $secret, $accountID = "", $authType = "JWT") {
            if ($authType == "OAuth") {
                $this->OAuthClient = $API_KEY;
                $this->OAuthAccountID = $accountID;
            } else {
                $this->payload["iss"] = $API_KEY;
                $this->payload["exp"] = strtotime("+10 days");
            }
            $this->secret = $secret;
        }

        public function base64UrlGenetate($key) {
            return str_replace(['+', '/', '='], ['-', '_', ''], base64_encode($key));
        }

        public function JWTTokenGenerate() {
            $base64UrlHeader = $this->base64UrlGenetate(json_encode($this->header));
            $base64UrlPayload = $this->base64UrlGenetate(json_encode($this->payload));
            
            $signature = hash_hmac('sha256', $base64UrlHeader . "." . $base64UrlPayload, $this->secret, true);
            $base64UrlSignature = $this->base64UrlGenetate($signature);

            $jwtToken = $base64UrlHeader . "." . $base64UrlPayload . "." . $base64UrlSignature;
            return $jwtToken;
        }

        public function OAuthTokenGenerate() {
            $oauthUrl = 'https://zoom.us/oauth/token?grant_type=account_credentials&account_id=' . $this->OAuthAccountID;
            $authHeader = 'Basic ' . base64_encode($this->OAuthClient . ':' . $this->secret);
            $curl = curl_init();
    
            curl_setopt_array($curl, array(
                CURLOPT_URL => $oauthUrl,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYPEER => false,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_POST => true,
                CURLOPT_HTTPHEADER => array('Authorization: ' . $authHeader)
            ));

            $response = curl_exec($curl);            
            $err = curl_error($curl);
            curl_close($curl);

            if ($err) {
                echo "cURL Error #:" . $err;
                return false;
            } else {
                $oauthResponse = json_decode($response, true);
                $accessToken = $oauthResponse['access_token'];
                return $accessToken;
            }
        }

        public function cURLQueries($url, $jwtToken, $query = "", $request = "POST") {
            $curl = curl_init();
    
            curl_setopt_array($curl, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_SSL_VERIFYPEER => false,
                CURLOPT_ENCODING => "",
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => $request,
                CURLOPT_POSTFIELDS => !empty($query) ? json_encode($query) : "",
                CURLOPT_HTTPHEADER => array(
                    "authorization: Bearer {$jwtToken}",
                    "content-type: application/json"
                ),
            ));

            $response = curl_exec($curl);            
            $err = curl_error($curl);
            curl_close($curl);

            if ($err) {
                echo "cURL Error #:" . $err;
                return false;
            } else {
                return $response;
            }
        }
    }