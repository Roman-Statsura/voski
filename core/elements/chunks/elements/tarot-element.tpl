{set $arr = []}
{set $arr[] = $price}

{set $tvFilters = 'consultIDTarot=='~$id~',consultStatusSession==1'}
{set $consultationsList = '!pdoResources' | snippet : [
    'parents' => 36,
    'sortby' => 'publishedon',
    'sortdir' => 'DESC',
    'includeTVs' => 'consultIDTarot, consultStatusSession',
    'includeContent' => '1',
    'tvFilters' => $tvFilters,
    'return' => 'json',
    'limit' => 0
] | json_decode : true}

<div class="tarot-readers-block__item ajax-item">
    <div class="tarot-readers-block__photo">
        {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
            'imageField' => $photo,
            'options' => 'w=140&h=140&zc=C&q=85',
            'class' => 'tarot-readers-photo',
            'link' => $_modx->makeUrl($id)
        ]}
    </div>
    <div class="tarot-readers-block__info">
        <div class="tarot-readers-block__info--items">
            <h3 class="tarot-readers-block__name">
                {$pagetitle}
            </h3>

            <div class="tarot-readers-block__info--list">
                <div class="tarot-readers-block__item--label">
                    {'@FILE chunks/elements/rating.tpl' | chunk : [
                        'count' => 5,
                        'number' => '@FILE snippets/avgRating.php' | snippet : ['idTarot' => $id]
                    ]}
                </div>
                <div class="tarot-readers-block__item--text font-weight--500">
                    {count($consultationsList)} 
                    {'@FILE snippets/word.php' | snippet : [
                        'number' => count($consultationsList),
                        'titles' => ["сессия", "сессий", "сессий"]
                    ]}
                </div>
            </div>

            {if $experience != ""}
                <div class="tarot-readers-block__info--list">
                    <div class="tarot-readers-block__item--label">Опыт консультрования:</div>
                    <div class="tarot-readers-block__item--text">{$experience} лет</div>
                </div>
            {/if}
            {if $price != ""}
                <div class="tarot-readers-block__info--list">
                    <div class="tarot-readers-block__item--label">Цена за сеанс:</div>
                    <div class="tarot-readers-block__item--text">{$price} ₽</div>
                </div>
            {/if}
            <div class="tarot-readers-block__text">
                {$content | truncate: '250'}
            </div>
        </div>

        <div class="tarot-readers-block__buttons">
            {'@FILE chunks/elements/button.tpl' | chunk : [
                'buttonTitle' => 'Подробнее »',
                'type' => 'link',
                'link' => $_modx->makeUrl($id),
                'theme' => 'transparent'
            ]}
            {'@FILE chunks/elements/button.tpl' | chunk : [
                'type' => 'link',
                'buttonTitle' => 'Записаться',
                'link' => $_modx->makeUrl($id) ~ '#signup'
            ]}
        </div>
    </div>
</div>