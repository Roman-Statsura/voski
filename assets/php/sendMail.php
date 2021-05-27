<?php
    require_once '../../core/model/modx/modx.class.php';
    $modx = new modX();
    $modx->initialize('web');
    $modx->getService('error','error.modError', '', '');

    function sendMail($modx, $mailTo, $subjectMail = "", $chunkEmail = "", $properties = []) {
        $message = $modx->getChunk($chunkEmail, $properties);

        $modx->getService('mail', 'mail.modPHPMailer');
        $modx->mail->set(modMail::MAIL_BODY, $message);
        $modx->mail->set(modMail::MAIL_FROM, $modx->getOption('emailsender'));
        $modx->mail->set(modMail::MAIL_FROM_NAME, $modx->getOption('site_name'));
        $modx->mail->set(modMail::MAIL_SUBJECT, $subjectMail);
        $modx->mail->address('to', $mailTo);
        $modx->mail->setHTML(true);

        if (!$modx->mail->send()) {
            $modx->log(modX::LOG_LEVEL_ERROR,'An error occurred while trying to send the email: ' . $modx->mail->mailer->ErrorInfo);
            return false;
        }

        $modx->mail->reset();
        return true;
    }

    /*$properties = [
        "clientName" => "Debug Client Name",
        "datetime"   => "2021-05-05 13:00",
        "tarotName"  => "Debug Tarot Name"
    ];
    sendMail($modx, "imfurypro@gmail.com", "Вы успешно записаны на, на сайте Voski", 'consultationEmail', $properties);*/