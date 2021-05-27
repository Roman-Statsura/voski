<?php
$filter = array();
    if(isset($_GET['speciallization'])){
        if($_GET['specialization'] !== ''){
            $filter[] = 'specialization=='.$_GET['specialization'];
        }
    }
    return implode(',', $filter);