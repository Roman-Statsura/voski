<!DOCTYPE html>
<html lang="ru">
    <head>
        {'@FILE chunks/globals/head.tpl' | chunk}
        
        {block 'head'}
        {/block}
    </head>
    <body>
        {'@FILE chunks/blocks/consultation.tpl' | chunk : [
            'photo' => $_modx->resource.consultIDTarot | resource: 'tv.photo',
            'tarotName' => $_modx->resource.consultIDTarot | resource: 'pagetitle',
            'consultIDClient' => $_modx->resource.consultIDClient,
            'consultIDTarot' => $_modx->resource.consultIDTarot,
            'idConsult' => $_modx->resource.id,
            'consultDatetime' => $_modx->resource.consultDatetime
        ]}
    </body>
</html>