{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk : [
        'classes' => 'background_snow-white'
    ]}
    
    {set $cardInfo = $_modx->config['Reg.CardInfo']}
    {if $cardInfo}
        <div class="login-steps">
            <div class="login-steps__container container">
                <div class="login-steps__content login-steps-content">
                    <div class="login-steps-content__step active" data-id="1" data-parent="1" type-form="registration">
                        <div class="login-steps-content__step--number">
                            1
                        </div>
                        <div class="login-steps-content__step--title">
                            Регистрация
                        </div>
                    </div>
                    <div class="login-steps-content__step" data-id="2" data-parent="1" type-form="bank">
                        <div class="login-steps-content__step--number">
                            2
                        </div>
                        <div class="login-steps-content__step--title">
                            Привязка карты
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/block} 

{block 'content'}
    {'@FILE chunks/blocks/registry.tpl' | chunk}
{/block} 

