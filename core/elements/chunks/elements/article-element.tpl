{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon-new.png' : $preview,
    'options' => $optionThumb == '' ? 'w=273&h=174&zc=C&q=85' : $optionThumb
]}

{set $thumbFromPhotoWebp = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon-new.png' : $preview,
    'options' => $optionThumb == '' ? 'w=273&h=174&zc=C&q=85&f=webp' : $optionThumb ~ '&f=webp'
]}

<a href="/{$uri}" class="articles-list__item {$full ? 'articles-list__item--full' : ''}">
    <div class="articles-list__item--image">
        <picture>
            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
            <img class="articles-list__item_image" src="{$thumbFromPhoto}" alt="" />
        </picture>
    </div>
    <div class="articles-list__item--body articles-list-body">
        <div class="articles-list-body__title">
            {$pagetitle}
        </div>
        <div class="articles-list-body__content">
            {$content}
        </div>
        <div class="articles-list-body__date">
            {$publishedon}
        </div>
    </div>
</a>