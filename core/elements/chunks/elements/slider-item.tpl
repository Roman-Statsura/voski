<div class="swiper-slide helped-slider-swiper__slide">
    <div class="swiper-slide__image">
        {set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
            'input' => $image,
            'options' => 'w=274&h=274&zc=C&q=85'
        ]}
        
        {set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
            'input' => $image,
            'options' => 'w=274&h=274&zc=C&q=85&f=webp'
        ]}
    
        <picture>
            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
            <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
        </picture>
    </div>
    <div class="swiper-slide__info">
        <div class="swiper-slide__info--text">
            {$text}
        </div>
        <div class="swiper-slide__info--name">
            {$name}
        </div>
    </div>
</div>