<div class="block-list-element grid-elements--{$countElem}">
    <div class="block-list-element__icon">
        {if $iconType == "svgElem"}
            {$icon | chunk}
        {else}
            {set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                'input' => $icon,
                'options' => 'w=275&h=174&zc=C&q=85'
            ]}
            {set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                'input' => $icon,
                'options' => 'w=275&h=174&zc=C&q=85&f=webp'
            ]}

            <picture>
                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
            </picture>
        {/if}
    </div>
    <div class="block-list-element__info">
        <div class="block-list-element__title">
            {$title}
        </div>
        <div class="block-list-element__desc">
            {$desc}
        </div>
    </div>
</div>