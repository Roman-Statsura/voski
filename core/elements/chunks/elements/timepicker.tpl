
<label for="{$id}" class="">
    <select class="form__input form__input--select login-tpl-form__item--input timepicker_input {$classesList}" name="{$name}" id="{$id}" {$attrs}>
        {set $timepicker = '!timepicker' | snippet}
        {foreach $timepicker as $key => $schItem}
            {set $valueSet = ""}
            {if $value != ""}
                {if $value == $schItem}
                    {set $valueSet = "selected"}
                {/if}
            {else}
                {if $key == 0}
                    {set $valueSet = "selected"}
                {/if}
            {/if}
            <option value="{$schItem}" {$valueSet}>{$schItem}</option>
        {/foreach}
    </select>
</label>
