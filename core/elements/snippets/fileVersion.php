<?php
    $filepath = $_SERVER["DOCUMENT_ROOT"] . '/' . $input;

    if (file_exists($filepath)) {
        return $input . '?v=' . date('dmYHis', filemtime($filepath));
    }