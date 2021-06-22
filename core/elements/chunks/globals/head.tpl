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

<link rel="apple-touch-icon" sizes="57x57" href="/assets/img/favicons/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="/assets/img/favicons/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="/assets/img/favicons/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="/assets/img/favicons/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="/assets/img/favicons/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="/assets/img/favicons/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="/assets/img/favicons/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="/assets/img/favicons/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="/assets/img/favicons/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="/assets/img/favicons/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="/assets/img/favicons/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="/assets/img/favicons/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="/assets/img/favicons/favicon-16x16.png">
<link rel="manifest" href="/assets/img/favicons/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="/assets/img/favicons/ms-icon-144x144.png">
<meta name="theme-color" content="#ffffff">