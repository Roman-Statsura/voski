{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}

    {'@FILE chunks/blocks/articles-detailed.tpl' | chunk : [
        'idParent' => $_modx->resource.parent
        'idResource' => $_modx->resource.id
        'publishedon' => $_modx->resource.publishedon
        'pagetitle' => $_modx->resource.pagetitle
        'content' => $_modx->resource.content
        'preview' => $_modx->resource.preview
        'includeTVs' => 'preview, tags'
    ]}
{/block}