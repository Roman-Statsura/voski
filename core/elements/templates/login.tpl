{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk}
{/block} 

{block 'content'}
    {'@FILE chunks/blocks/login.tpl' | chunk}
{/block} 