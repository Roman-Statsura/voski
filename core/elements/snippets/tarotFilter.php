<?php
$filter = array();
	if (isset($_GET['specialization'])) {
        if (!empty($_GET['specialization'])) {
			$newSpecArray = array();

			if ($_GET['specialization'][0] !== "0") {
				foreach ($_GET['specialization'] as $key => $specItem) {
					if (!in_array("specialization==%{$specItem}%", $newSpecArray)) {
						$newSpecArray[] = "specialization==%{$specItem}%";
					}
				}
				$filter[] = implode('||', $newSpecArray);
			}
        }
    }

    if (isset($_GET['experience'])) {
        if (!empty($_GET['experience']) && $_GET['experience'] !== '0') {
			if (strpos($_GET['experience'], "+") !== false) {
				$expReady = str_replace("+", "", $_GET['experience']);
				$expResult = "experience>={$expReady}";
			} else {
				$expExplode = explode("-", $_GET['experience']);
				$expResult = "experience>={$expExplode[0]},experience<={$expExplode[1]}";
			}

            $filter[] = $expResult;
        }
    }

    if (isset($_GET['gender'])) {
        if (!empty($_GET['gender']) && $_GET['gender'] !== "0") {
			switch ($_GET['gender']) {
				case 'male':
					$genderCode = 1;
					break;
				case 'female':
					$genderCode = 2;
					break;
				default:
					$genderCode = 1;
					break;
			}

            $filter[] = "gender=={$genderCode}";
        }
    }

	if (isset($_GET['price'])) {
        if (!empty($_GET['price'])) {
			$newPriceArray = array();

			foreach ($_GET['price'] as $key => $priceItem) {
				$expExplode = explode("-", $priceItem);

				foreach ($expExplode as $expItem) {
					$newPriceArray[] = $expItem;
				}
			}

			$priceFrom = min($newPriceArray);
			$priceTo = max($newPriceArray);
				
			$expResult = "price>={$priceFrom},price<={$priceTo}";
            $filter[] = $expResult;
        }
    }

    if (isset($_GET['priceFrom']) && isset($_GET['priceTo'])) {
        if (!empty($_GET['priceFrom']) && !empty($_GET['priceTo'])) {
            $filter[] = "price>={$_GET['priceFrom']},price<={$_GET['priceTo']}";
        }
    }

	$filter[] = "zoomID!=''";

	//get count of found resources
	$params_count = array(
		'parents' => 2,
		'limit' => $limit,
		'select' => 'id, price',
		'includeTVs' => $includeTVs,
		'tvPrefix' => '',
		'showHidden' => '1',
		'return' => 'json',
		'tvFilters' => implode(',', $filter)
	);

	$prices = array();
	$resPrices = json_decode($modx->runSnippet('pdoResources', $params_count));

	foreach ($resPrices as $resPricesItem) {
		$prices[] = $resPricesItem->price;
	}

	$maxPrice = max($prices);
	$modx->setPlaceholder('maxPrice', $maxPrice);

	$count = $modx->runSnippet('pdoResources', $params_count);
	$count = count(explode(',', $count))-1;
	$modx->setPlaceholder('count', $count);

	/**
	* Подсчитываем среднее количество консультации за неделю
	* Array $arrayTarotConsult - массив тарологов
	**/
	$tarotParams = array(
		'parents' => 2,
		'limit' => $limit,
		'select' => 'id',
		'includeTVs' => 'rating',
		'tvPrefix' => '',
		'showHidden' => '1',
		'return' => 'json',
		'tvFilters' => implode(',', $filter)
	);

	$tarotList = json_decode($modx->runSnippet('pdoResources', $tarotParams));
	$arrayTarotConsult = [];

	$consultOnWeek = json_decode($modx->runSnippet('pdoResources', array(
		'parents' => 36,
		'select' => 'id',
		'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
		consultDesc, consultStatusSession, consultDuration, consultSended',
		'tvPrefix' => '',
		'includeContent' => 1,
		'sortby' => 'consultDatetime',
		'sortdir' => 'ASC',
		'return' => 'json',
		'tvFilters' => 'consultDatetime>=' . date("Y-m-d") . '%,consultDatetime<=' . date("Y-m-d", strtotime("+7 days")) . '%',
		'limit' => 0
	)));

	foreach ($tarotList as $tarotItem) {
		$countConsult = 0;
		$sumRating = 0;
		$avgRating = 0;

        foreach ($tarotItem->rating as $ratingItem) {
            $sumRating += $ratingItem->rating;
        }

		foreach ($consultOnWeek as $consultItem) {
			if ($consultItem->consultIDTarot == $tarotItem->id) {
				$countConsult++;
			}

			$arrayTarotConsult[$tarotItem->id] = [
				'avgConsult' => $countConsult / 7,
				'avgRating' => $sumRating / count($tarotItem->rating)
			];
		}
	}
	asort($arrayTarotConsult);

	$idsTarot = [];
	foreach ($arrayTarotConsult as $key => $arrayTarotItem) {
		$idsTarot[] = $key;
	}
	
	$params = array(
		'parents' => $parents,
		'resources' => implode(", ", $idsTarot),
		'includeTVs' => $includeTVs,
		'tvPrefix' => '',
		'tpl' => $tpl,
		'includeContent' => $includeContent,
		'sortby' => false,
		'sortdir' => false,
		'return' => $return,
		'tvFilters' => implode(',', $filter),
		'limit' => $limit ? 0 : $limit
	);

	$more = $count - $offset - $limit;
	$lim = $more > $limit ? $limit : $more;

	$button = '';
	if($more > 0){
		$button = '<a id="load-more" href="#" class="btn-lg btn-primary">Загрузить еще '.$lim.' из '.$more.'</a>';
	}

	return $modx->runSnippet('pdoResources', $params);