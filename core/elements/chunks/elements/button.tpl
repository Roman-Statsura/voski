{if $type == 'button'}
    <button class="button button-size--{$size == '' ? 'normal' : $size} button-theme--{$theme == '' ? 'mint' : $theme} {$classes}" {$dataAttr}>
        {$buttonTitle}
    </button>
{elseif $type == 'link'}
    <a href="{$link == '' ? '#' : '/' ~ $link}" class="button button-size--{$size == '' ? 'normal' : $size} button-theme--{$theme == '' ? 'mint' : $theme} {$classes}" {$dataAttr}>
        {$buttonTitle}
    </a>
{else} 
    <button class="button button-size--{$size == '' ? 'normal' : $size} button-theme--{$theme == '' ? 'mint' : $theme} {$classes}" {$dataAttr}>
        {$buttonTitle}
    </button>
{/if}