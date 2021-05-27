{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}

    {'@FILE chunks/blocks/articles-list.tpl' | chunk : [
        'idParent' => $_modx->resource.id
        'includeTVs' => 'preview, tags'
    ]}
{/block}