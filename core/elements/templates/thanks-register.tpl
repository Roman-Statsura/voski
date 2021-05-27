{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk : [
        'classes' => 'background_snow-white'
    ]}
    {'@FILE chunks/blocks/thanks-register.tpl' | chunk}
{/block} 
