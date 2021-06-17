{if $theme == ''} 
    {set $theme = 'white'}
{/if}

{if $onlytop == ''} 
    {set $onlytop = 'wawe-container--onlytop'}
{/if}

<div class="just-block {$backgroundTheme} {$wawe ? 'wawe-container wawe-container-theme--'~$theme~' '~$onlytop~'' : ''}">
    <div class="just-block-container container {$containerSize ? 'container--'~$containerSize~'' : ''} {$tiny ? 'container--tiny' : ''}">
        <div class="just-block-container__content just-block-content">
            {if $title != ''}
                <div class="just-block-content__header">
                    {if $preview}
                        {set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                            'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon--big.png' : $preview,
                            'options' => $optionThumb == '' ? 'w=772&h=490&zc=C&q=85' : $optionThumb
                        ]}

                        {set $thumbFromPhotoWebp = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                            'input' => $preview == '' ? '/assets/img/blocks/article-empty_icon--big.png' : $preview,
                            'options' => $optionThumb == '' ? 'w=772&h=490&zc=C&q=85&f=webp' : $optionThumb ~ '&f=webp'
                        ]}
                        <div class="just-block-content__picture">
                            <picture>
                                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                                <img class="just-block-content__image" src="{$thumbFromPhoto}" alt="" />
                            </picture>
                        </div>
                    {/if}

                    <h1 class="just-block-content__header--title {$textAlign ? 'text-align_'~$textAlign~'' : ''}">{$title}</h1>
                </div>
            {/if}
            <div class="just-block-content__body {$fontSize ? 'font-size_'~$fontSize~'' : ''} {$pNoMargin ? 'paragraph--no-margin' : ''} just-block__justify--{$justifyAlign == '' ? 'center' : $justifyAlign} just-block__direction--{$direction == '' ? 'row' : $direction}">
                {$block}
            </div>
        </div>
    </div>
</div>