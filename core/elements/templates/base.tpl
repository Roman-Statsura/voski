<!DOCTYPE html>
<html lang="ru">
    <head>
        {'@FILE chunks/globals/head.tpl' | chunk}
        
        {block 'head'}
        {/block}
    </head>
    <body>
        <div class="global-container">
            {'@FILE chunks/globals/header.tpl' | chunk}

            {block 'body'}
            {/block}
        </div>

        {block 'content'}
        {/block}

        {'@FILE chunks/globals/footer.tpl' | chunk}

        {block 'scripts'}
        {/block}
    </body>
</html>