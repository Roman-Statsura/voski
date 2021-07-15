{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=573&h=431&zc=C&q=85'
]}

{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=573&h=431&zc=C&q=85&f=webp'
]}

<div class="success">
    <div class="container success-container">
        <div class="success__image">
            <picture>
                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
            </picture>
        </div>
        <div class="success__info success-info">
            <div class="success-info__title">
                {$title}
            </div>
            <div class="success-info__text">
                {$text}
            </div>
            <div class="success-info__button">
                {'@FILE chunks/elements/button.tpl' | chunk : [
                    'type' => 'link'
                    'buttonTitle' => 'На главную'
                    'link' => '/'
                ]}
            </div>
        </div>
    </div>
</div>