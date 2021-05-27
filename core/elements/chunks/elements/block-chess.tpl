{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=573&zc=C&q=85'
]}

{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=573&zc=C&q=85&f=webp'
]}

<div class="block-chess">
    <div class="block-chess__block block-chess__image">
        <picture>
            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
            <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
        </picture>
    </div>
    <div class="block-chess__block">
        <div class="block-chess__block--title">
            {$title}
        </div>
        <div class="block-chess__block--desc">
            {$desc}
        </div>
    </div>
</div>