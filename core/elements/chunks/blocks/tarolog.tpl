{set $objs = '!pdoResources' | snippet : [
    'parents' => 2
    'sortby' => 'RAND()'
    'includeTVs' => 'photo'
    'includeContent' => '1'
    'setTotal' => 1
    'return' => 'json'
    'limit' => $limit == '' ? 5 : $limit
] | json_decode : true}

<div class="tarolog wawe-container wawe-container-theme--white">
    <div class="tarolog-container container">
        <div class="tarolog-container__content tarolog-content">
            <div class="tarolog-content__header">
                <h2 class="tarolog-content__header--title">В нашей базе [[+total]] лучших таргологов</h2>
            </div>
            <div class="tarolog-content__body">
                <div class="tarolog-content__block tarolog-content__items">
                    {foreach $objs as $item}
                        {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                            'link' => $item.uri,
                            'imageField' => $item['tv.photo']
                        ]}
                    {/foreach}
                </div>
                <div class="tarolog-content__block">
                    {'@FILE chunks/elements/button.tpl' | chunk : [
                        'buttonTitle' => 'Подобрать своего таролога'
                        'type' => 'link'
                        'link' => 'select-tarot'
                    ]}
                </div>
            </div>
        </div>
    </div>
</div>