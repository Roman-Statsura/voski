{set $image = '/assets/img/blocks/faq-new.png'}

{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=273&h=264&zc=C&q=85'
]}

{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $image,
    'options' => 'w=273&h=264&zc=C&q=85&f=webp'
]}

<div class="faq">
    <div class="faq-container container">
        <div class="faq-container__content faq-content">
            <div class="faq-content__body">
                <div class="faq-content__left">
                    <div class="faq-content__left-title">
                        Часто задаваемые вопросы
                    </div>
                    <div class="is-desktop">
                        <div class="faq-content__left-desc">
                            Остались вопросы? Получите консультацию специалиста
                        </div>
                        <div class="faq-content__left-image">
                            <picture>
                                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                                <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
                            </picture>
                            <div class="faq-content__left-button">
                                {'@FILE chunks/elements/button.tpl' | chunk : [
                                    'type' => 'link',
                                    'buttonTitle' => 'Получить консультацию'
                                ]}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="faq-content__right">
                    {set $objs = 6 | resource: 'qa' | json_decode: true}
                    <div class="faq-content__list">
                        {foreach $objs as $key => $item}
                            {if $item.active == 1}
                                <div class="faq-content__item hidden">
                                    <div class="faq-content__item-question">{$item.question}</div>
                                    <div class="faq-content__item-answer">
                                        {$item.answer}
                                    </div>
                                </div>
                            {/if}
                        {/foreach}
                    </div>

                    <div class="faq-content__block is-mobile">
                        <div class="faq-content__left-desc">
                            Остались вопросы? Получите консультацию специалиста
                        </div>
                        <div class="faq-content__left-image">
                            <picture>
                                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                                <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
                            </picture>
                            <div class="faq-content__left-button">
                                {'@FILE chunks/elements/button.tpl' | chunk : [
                                    'buttonTitle' => 'Получить консультацию'
                                ]}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{$_modx->regClientScript('<script>
    let faqItems = document.querySelectorAll(".faq-content__item");

    faqItems.forEach(element => {
        element.addEventListener("click", function () {
            this.classList.toggle("hidden");
        });
    });
</script>',true)}