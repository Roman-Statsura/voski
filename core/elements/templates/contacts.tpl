{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}

    {'@FILE chunks/blocks/just-block.tpl' | chunk : [
        'wawe' => 0,
        'direction' => 'column',
        'tiny' => 1,
        'pNoMargin' => 1,
        'title' => $_modx->resource.longtitle != "" ? $_modx->resource.longtitle : $_modx->resource.pagetitle,
        'block' => $_modx->resource.content
    ]}
    
    {'@FILE chunks/blocks/contacts-block.tpl' | chunk}
{/block}