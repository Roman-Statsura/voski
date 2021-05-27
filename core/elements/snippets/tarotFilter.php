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
        if ($_GET['experience'] !== '' && $_GET['experience'] !== '0') {
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
        if ($_GET['gender'] !== "" && $_GET['gender'] !== "0") {
            $filter[] = "gender=={$_GET['gender']}";
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

			if ($priceTo > 0) {
				$expResult = "price>={$priceFrom},price<={$priceTo}";
			} else {
				$expResult = "price>={$priceFrom}";
			}

            $filter[] = $expResult;
        }
    }

    if (isset($_GET['priceFrom']) && isset($_GET['priceTo'])) {
        if ($_GET['priceFrom'] !== '' && $_GET['priceTo'] !== '') {
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

	$params = array(
		'parents' => $parents,
		'limit' => $limit,
		'includeTVs' => $includeTVs,
		'tvPrefix' => '',
		'tpl' => $tpl,
		'includeContent' => $includeContent,
		'sortby' => $sortby,
		'sortdir' => $sortdir,
		'return' => $return,
		'tvFilters' => implode(',', $filter),
		'limit' => 0
	);

	$more = $count - $offset - $limit;
	$lim = $more > $limit ? $limit : $more;

	$button = '';
	if($more > 0){
		$button = '<a id="load-more" href="#" class="btn-lg btn-primary">Загрузить еще '.$lim.' из '.$more.'</a>';
	}

	return $modx->runSnippet('pdoResources', $params);