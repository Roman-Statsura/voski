{if $_modx->resource.description == ''}
    {set $description = $_modx->resource.content | truncate: 200 : '' | strip_tags}
{else}
    {set $description = $_modx->resource.description}
{/if}

<meta charset="{$_modx->config['modx_charset']}">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, shrink-to-fit=no">
<meta name="description" content="{$description}">
<meta name="keywords" content="{$_modx->resource.keywords}">

<title>{'@FILE snippets/pdoTools/pdoTitle.php' | snippet} | {$_modx->config['site_name']}</title>

{set $mainCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/main.css'
]}

<link rel="preload" as="style" href="{$mainCSS}">

<!--<link rel="preload" href="/assets/fonts/Montserrat/Montserrat-Regular.woff" as="font" crossorigin="anonymous">-->

<link href="{$mainCSS}" rel="stylesheet">