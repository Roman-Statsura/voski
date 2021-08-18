{set $imageField = '/assets/img/blocks/videocall-new.png'}

{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => 'w=603&h=552&zc=C&q=85'
]}

{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => 'w=603&h=552&zc=C&q=85&f=webp'
]}

<div class="main-header">
    <div class="main-header-container container">
        <div class="main-header-container__content main-header-content">
            <div class="main-header-content__block">
                <div class="main-header-content__block_item">
                    <h1 class="main-header-content__block_title">
                        Подберите лучшего таролога удалённо: 
                        <span class="text-color--mint">задайте нужный для себя вопрос</span>
                    </h1>
                </div>
                <div class="main-header-content__block_item">
                    от 2 000 ₽ за сессию
                </div>
                <div class="main-header-content__block_item">
                    {'@FILE chunks/elements/button.tpl' | chunk : [
                        'buttonTitle' => 'Подобрать таролога'
                        'type' => 'link'
                        'link' => 'select-tarot'
                    ]}
                    <div class="main-header-content__block_text button__aftertext">
                        Это бесплатно
                    </div>
                </div>
            </div>
            <div class="main-header-content__block image-block">
                <picture>
                    <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                    <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
                </picture>
            </div>
        </div>
    </div>
</div>