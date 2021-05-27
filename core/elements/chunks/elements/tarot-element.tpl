{set $arr = []}
{set $arr[] = $price}
<div class="tarot-readers-block__item ajax-item">
    <div class="tarot-readers-block__photo">
        {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
            'imageField' => $photo
            'options' => 'w=140&h=140&zc=C&q=85'
            'class' => 'tarot-readers-photo'
        ]}
    </div>
    <div class="tarot-readers-block__info">
        <h3 class="tarot-readers-block__name">
            {$pagetitle}
        </h3>
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

        <div class="tarot-readers-block__buttons">
            {'@FILE chunks/elements/button.tpl' | chunk : [
                'buttonTitle' => 'Подробнее »'
                'type' => 'link'
                'link' => $_modx->makeUrl($id)
                'theme' => 'transparent'
            ]}
            {'@FILE chunks/elements/button.tpl' | chunk : [
                'type' => 'link'
                'link' => $_modx->makeUrl($id)
                'buttonTitle' => 'Записаться'
            ]}
        </div>
    </div>
</div>