{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/blocks/success.tpl' | chunk : [
        'image' => '/assets/img/blocks/404-new.png'
        'title' => 'Ошибка'
        'text' => 'Извините, но страница которую вы ищете не существует. Пожалуйста вернитесь на главную страницу.'
    ]} 
{/block}