<?php
    require_once $_SERVER['DOCUMENT_ROOT'] . '/assets/php/yookassa/Luhn.php';

    $luhn = new Luhn();
    $vnumber = $_GET['vnumber'];

    if (!empty($vnumber)){
        if ($luhn->validate(substr($vnumber, 0, -1), substr($vnumber, -1, 1)) == true) {
            $vresult = true;
        } else {
            $vresult = "Операция завершилась с ошибкой! Ошибка: неверно введена карта или карты не существует";
        }

        echo $vresult;
    } else {
        echo "Операция успешно завершена, пожалуйста закройте данное окно.";
    }