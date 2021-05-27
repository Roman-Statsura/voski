{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => $options == '' ? 'w=135&h=135&zc=C&q=85' : $options
]}

{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => $options == '' ? 'w=135&h=135&zc=C&q=85' : $options ~'&f=webp'
]}

{if $class == ""}
    {set $class = "tarolog-item"}
{/if}

<div class="{$class}">
    <a href="" class="{$class != '' ? $class ~ '__link' : ''}">
        <picture>
            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
            <img class="{$class != '' ? $class ~ '__block_image' : ''}" src="{$thumbFromPhoto}" alt="" />
        </picture>
    </a>
</div>