<?php
    include "/core/components/login/controllers/web/sms/SMSService.php";

    $smsService = new SMSService();

    function generateSMSCode($number)
    {
        $arr = array('0','1','2','3','4','5','6','7','8','9');
        // Генерируем пароль для смс
        $pass = "";
        for($i = 0; $i < $number; $i++)
        {
            // Вычисляем произвольный индекс из массива
            $index = rand(0, count($arr) - 1);
            $pass .= $arr[$index];
        }
        return $pass;
    }

    return $smsService->sendMessage($username, generateSMSCode(6));