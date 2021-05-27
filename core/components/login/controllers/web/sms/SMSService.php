<?php
/**
 * Скрипт СМС-шлюза, настроено для двух шлюзов 
 * - Stream Telecom (https://stream-telecom.ru/)
 * - IQSMS (https://iqsms.ru/)
 * 
 * Чтобы настроить скрипт к работе, необходимо написать логин ($login) и пароль ($password)
 * и написать Имя отправителя ($sadr). Позже в необходимом месте, вызвать одну из функции, отвечающий
 * за отправку через шлюзы.
 * 
 * Настройка шлюза, происходит непосредственно на сайте шлюзов (указано выше).
 **/

class SMSService
{
    const ENDPOINT = 'http://gateway.api.sc/get/';

    private $login;
    private $password;
    private $sadr;

    public function __construct() {
        $this->login = 'ImFuryPro';
        $this->password = 'oemcwxNGtt';
        $this->sadr = 'WINSERV';
    }

    /**
     * Отправка сообщения Stream Telecom
     *
     * @param $phone string Номер телефона
     * @param $message string Текст сообщения
     * @return string URL запроса
     */
    public function sendMessageStream($phone, $message) {
        $params = [
            'user' => $this->login,
            'pwd' => $this->password,
            'sadr' => $this->sadr,
            'dadr' => $phone,
            'text' => 'Ваш код подтверждения на сайте Voski: ' . $message
        ];

        setcookie("smsCode", $message); // Test SMS Code
        $_SESSION['smsCode'] = $message;
        $url = self::ENDPOINT . '?' . http_build_query($params);

        return $url;
    }

    /**
     * Отправка сообщения IQSMS
     *
     * @param $phone string Номер телефона
     * @param $message string Текст сообщения
     * @return array Тело запроса
     */
    public function sendMessageIQSMS($phone, $message) {
        $host = 'gate.iqsms.ru';
        $port = '80';

        $fp = fsockopen($host, $port, $errno, $errstr);
        if (!$fp) {
            return "errno: $errno \nerrstr: $errstr\n";
        }

        fwrite($fp, "GET /send/" .
            "?phone=" . rawurlencode($phone) .
            "&text=" . rawurlencode('Ваш код подтверждения на сайте Voski: ' . $message) .
            ($this->sadr ? "&sender=" . rawurlencode($this->sadr) : "") .
            " HTTP/1.0\n");

        fwrite($fp, "Host: " . $host . "\r\n");
        fwrite($fp, "Authorization: Basic " . base64_encode($this->login. ":" . $this->password) . "\n");

        fwrite($fp, "\n");
        $response = "";

        while(!feof($fp)) {
            $response .= fread($fp, 1);
        }

        fclose($fp);
        list($other, $responseBody) = explode("\r\n\r\n", $response, 2);
        return $responseBody;
    }
}
