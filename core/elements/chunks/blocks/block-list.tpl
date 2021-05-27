<div class="block-list {$wawe ? 'wawe-container wawe-container-theme--'~$theme~' '~$onlytop~'' : ''}">
    <div class="block-list-container container">
        <div class="block-list__content block-list-content">
            {if $blockTitle != ""}
                <div class="block-list-content__header">
                    <h2 class="block-list-content__header--title">{$blockTitle}</h2>
                </div>
            {/if}
            <div class="block-list-content__body">
                <div class="block-list-content__list">
                    {foreach $elements as $elem}
                        {'@FILE chunks/elements/block-list-element.tpl' | chunk : [
                            'icon' => $elem.icon
                            'iconType' => $elem.iconType
                            'title' => $elem.title
                            'desc' => $elem.desc
                            'countElem' => count($elements)
                        ]}
                    {/foreach}
                </div>
            </div>
            {if $footerButton}
                <div class="block-list-content__footer">
                    {'@FILE chunks/elements/button.tpl' | chunk : [
                        'type' => 'link'
                        'buttonTitle' => 'Заполнить анкету и присоединиться к нам!'
                        'link' => 'profile/questionnaire'
                        'classes' => ''
                    ]}
                </div>
            {/if}
        </div>
    </div>
</div>