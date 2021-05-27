{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}

    {'@FILE chunks/blocks/just-block.tpl' | chunk : [
        'wawe' => 0,
        'direction' => 'column',
        'textAlign' => 'left',
        'fontSize' => 'normal',
        'containerSize' => 'md',
        'preview' => $_modx->resource.preview,
        'title' => $_modx->resource.pagetitle,
        'block' => $_modx->resource.content
    ]}
{/block}