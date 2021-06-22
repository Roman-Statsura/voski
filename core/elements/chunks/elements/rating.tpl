{set $num = $number}
<div class="rating-element">
    {if !$hiddenNumber}
        <div class="rating-element--number">
            {if $number != ""}
                {if '@FILE snippets/isInt.php' | snippet : ['number' => $number]}
                    {$number~'.0'}
                {else}
                    {$number}
                {/if}
            {else}
                0
            {/if}
        </div>
    {/if}
    <div class="rating-element--stars {$classes}">
        {foreach 1..$count as $value}
            {if $num >= 1}
                {'@FILE chunks/icons/icon-star-fill.tpl' | chunk}
            {else} 
                {if $size == 20}
                    {'@FILE chunks/icons/icon-star-empty-20.tpl' | chunk}
                {else}
                    {if $num == 0.5}
                        {'@FILE chunks/icons/icon-star-half.tpl' | chunk}
                    {else}
                        {'@FILE chunks/icons/icon-star-empty.tpl' | chunk}
                    {/if}
                {/if}
            {/if}

            {set $num = $number - $value}
        {/foreach}
    </div>
</div>