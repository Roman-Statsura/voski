<div class="swiper-slide helped-slider-swiper__slide">
    <div class="swiper-slide__thumb">
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
</div>