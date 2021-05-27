{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon--big.png' : $preview,
    'options' => $optionThumb == '' ? 'w=772&h=490&zc=C&q=85' : $optionThumb
]}

{set $thumbFromPhotoWebp = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon--big.png' : $preview,
    'options' => $optionThumb == '' ? 'w=772&h=490&zc=C&q=85&f=webp' : $optionThumb ~ '&f=webp'
]}

{set $objs = '!pdoResources' | snippet : [
    'parents' => $idParent,
    'resources' => -$idResource,
    'includeTVs' => $includeTVs
    'includeContent' => '1'
    'return' => 'json'
    'limit' => 3
] | json_decode : true}

<div class="articles-detailed">
    <div class="articles-detailed-container container">
        <div class="articles-detailed__content articles-detailed-content">
            <div class="articles-detailed-content__body">
                <div class="articles-detailed-content__left">
                    <div class="articles-detailed-content__picture">
                        <picture>
                            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                            <img class="articles-list__item_image" src="{$thumbFromPhoto}" alt="" />
                        </picture>
                    </div>
                    <div class="articles-detailed-content__date">
                        {$publishedon}
                    </div>
                    <h1 class="articles-detailed-content__title">
                        {$pagetitle}
                    </h1>
                    <div class="articles-detailed-content__content">
                        {$content}
                    </div>
                </div>
                <div class="articles-detailed-content__sidebar">
                    <div class="articles-detailed-content__sidebar--title">
                        Последние новости
                    </div>
                    <div class="articles-detailed-content__sidebar--list">
                        {foreach $objs as $item}
                            {'@FILE chunks/elements/article-element.tpl' | chunk : [
                                'pagetitle' => $item.pagetitle
                                'content' => $item.content | truncate: 200 | strip_tags
                                'publishedon' => $item.publishedon | date: 'd.m.Y'
                                'preview' => $item['tv.preview']
                                'uri' => $item.uri
                                'views' => $item['tv.views']
                                'itemArray' => $item
                                'full' => 1
                            ]}
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>