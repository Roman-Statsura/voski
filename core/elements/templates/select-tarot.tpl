{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk : [
        'classes' => 'background_snow-white'
    ]}
    <div class="login-steps">
        <div class="login-steps__container container">
            <div class="login-steps__content login-steps-content">
                <div class="login-steps-content__step active" data-id="1" data-parent="1" type-form="questionnaire">
                    <div class="login-steps-content__step--number">
                        1
                    </div>
                    <div class="login-steps-content__step--title">
                        Анкета
                    </div>
                </div>
                <div class="login-steps-content__step" data-id="2" data-parent="1" type-form="gender-tarot">
                    <div class="login-steps-content__step--number">
                        2
                    </div>
                    <div class="login-steps-content__step--title">
                        Пол астролога
                    </div>
                </div>
                <div class="login-steps-content__step" data-id="3" data-parent="1" type-form="price-tarot">
                    <div class="login-steps-content__step--number">
                        3
                    </div>
                    <div class="login-steps-content__step--title">
                        Цена
                    </div>
                </div>
                <div class="login-steps-content__step" data-id="4" data-parent="1" type-form="select-tarot">
                    <div class="login-steps-content__step--number">
                        4
                    </div>
                    <div class="login-steps-content__step--title">
                        Выбор астролога
                    </div>
                </div>
            </div>
        </div>
    </div> 
    {'@FILE chunks/blocks/select-tarot.tpl' | chunk}
{/block} 
