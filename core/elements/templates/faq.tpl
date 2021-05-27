{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}

    {'@FILE chunks/blocks/faq.tpl' | chunk}
{/block}