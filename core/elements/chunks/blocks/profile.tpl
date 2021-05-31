{if $modx->user->isAuthenticated()}

    {set $swiperBundleJS = '@FILE snippets/fileVersion.php' | snippet : [
        'input' => '/assets/js/swiper-bundle.min.js'
    ]}
    {set $swiperBundleCSS = '@FILE snippets/fileVersion.php' | snippet : [
        'input' => '/assets/css/swiper-bundle.min.css'
    ]}

    {set $swiperBundleJSPreload = '<link rel="preload" as="script" href="'~$swiperBundleJS~'">'}
    {set $swiperBundlePreload = '<link rel="preload" as="style" href="'~$swiperBundleCSS~'">'}
    {set $swiperBundle = '<link href="'~$swiperBundleCSS~'" rel="stylesheet">'}

    {$swiperBundlePreload | htmlToHead: true}
    {$swiperBundleJSPreload | htmlToHead: true}
    {$swiperBundle | htmlToHead: true}

    {if $_modx->makeUrl($_modx->resource.id) == "profile/"}
        {'@FILE snippets/Redirect.php' | snippet : [
            'id' => '30'
            'isAuth' => '1'
        ]}
    {/if}

    <div class="profile">
        <div class="profile-settings">
            <div class="profile-settings__container container">
                <div class="profile-settings__content profile-settings-content swiper-container">
                    <div class="profile-settings-content__menu profile-settings-menu swiper-wrapper">
                        <a href="/profile/settings" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/settings'}button-theme--dark{else}button-theme--grey{/if}" data-id="1" data-parent="1" data-form="settings">Настройки</a>
                        <a href="/profile/finances" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/finances'}button-theme--dark{else}button-theme--grey{/if}" data-id="2" data-parent="1" data-form="finances">Финансы</a>
                        {if 32 | resource: 'published'}
                            <a href="/profile/messages" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/messages'}button-theme--dark{else}button-theme--grey{/if}" data-id="3" data-parent="1" data-form="messages">Сообщения</a>
                        {/if}
                        <a href="/profile/myconsultations" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/myconsultations'}button-theme--dark{else}button-theme--grey{/if}" data-id="4" data-parent="1" data-form="myconsultations">Мои консультации</a>
                        
                        {if $_modx->user.extended.usertype == 3}
                            <a href="/profile/calendar" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/calendar'}button-theme--dark{else}button-theme--grey{/if}" data-id="5" data-parent="1" data-form="calendar">Календарь</a>
                            <a href="/profile/questionnaire" class="swiper-slide profile-settings-menu__item button button-size--radius login-tpl-form__item--button {if $_modx->makeUrl($_modx->resource.id) == 'profile/questionnaire'}button-theme--dark{else}button-theme--grey{/if}" data-id="6" data-parent="1" data-form="questionnaire">Анкета</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div> 
        
        <div class="profile-body wawe-container wawe-container-theme--white wawe-container--onlytop">
            {if $_modx->user.extended.cardname == "" || $_modx->user.extended.creditnumber == "" ||
                $_modx->user.extended.datefinished == "" || $_modx->user.extended.cvc == ""}
                <div class="login-container login-container--wide container">
                    <div class="alert alert--error" style="display: block;">
                        {if $_modx->user.extended.usertype == 2}
                            Уважаемый клиент! Чтобы начать полноценно пользоваться нашим сервисом, для записи на консультацию к специалистам, 
                            необходимо привязать вашу банковскую карту во вкладке <a href="/profile/finances">Финансы</a> в настройках вашего профиля.
                        {else}
                            Уважаемый таролог! Чтобы начать полноценно пользоваться нашим сервисом и получать заявки на консультации,
                            необходимо привязать вашу банковскую карту во вкладке <a href="/profile/finances">Финансы</a> в настройках вашего профиля.
                        {/if}
                    </div>
                </div>
            {/if}

            {if $_modx->makeUrl($_modx->resource.id) == "profile/settings"}
                <div class="profile-body__block" data-id="1" data-parent="1" data-form="settings">
                    {'@FILE chunks/blocks/profile/settings.tpl' | chunk}
                </div>
            {/if}
            {if $_modx->makeUrl($_modx->resource.id) == "profile/finances"}
                <div class="profile-body__block" data-id="2" data-parent="1" data-form="finances">
                    {'@FILE chunks/blocks/profile/finances.tpl' | chunk}
                </div>
            {/if}
            {if $_modx->makeUrl($_modx->resource.id) == "profile/messages"}
                {if 32 | resource: 'published'}
                    <div class="profile-body__block" data-id="3" data-parent="1" data-form="messages">
                        {'@FILE chunks/blocks/profile/messages.tpl' | chunk}
                    </div>
                {/if}
            {/if}
            {if $_modx->makeUrl($_modx->resource.id) == "profile/myconsultations"}
                <div class="profile-body__block" data-id="4" data-parent="1" data-form="myconsultations">
                    {'@FILE chunks/blocks/profile/myConsultations.tpl' | chunk}
                </div>
            {/if}
            {if $_modx->user.extended.usertype == 3}
                {if $_modx->makeUrl($_modx->resource.id) == "profile/calendar"}
                    <div class="profile-body__block" data-id="5" data-parent="1" data-form="calendar">
                        {'@FILE chunks/blocks/profile/calendar.tpl' | chunk}
                    </div>
                {/if}
                {if $_modx->makeUrl($_modx->resource.id) == "profile/questionnaire"}
                    <div class="profile-body__block" data-id="6" data-parent="1" data-form="questionnaire">
                        {'@FILE chunks/blocks/profile/questionnaire.tpl' | chunk}
                    </div>
                {/if}
            {/if}

            {if $_modx->user.extended.usertype != 3}
                {if $_modx->makeUrl($_modx->resource.id) == "profile/calendar"}
                    {'@FILE snippets/Redirect.php' | snippet : [
                        'id' => '30'
                        'isAuth' => '1'
                    ]}
                {/if}
            {/if}
        </div>

        {if $_modx->user.extended.usertype == 2}
            <div class="button-sticky container">
                {'@FILE chunks/elements/button.tpl' | chunk : [
                    'type' => 'link'
                    'buttonTitle' => 'Подберите мне таролога'
                    'link' => 'select-tarot'
                    'classes' => ''
                ]}
            </div>
        {/if}
    </div>

    {$_modx->regClientScript($swiperBundleJS)}

    {$_modx->regClientScript('<script>
        let active = 1,
            menuList = document.querySelectorAll(".profile-settings-menu__item[data-id]"),
            blocksList = document.querySelectorAll(".profile-body__block[data-id]"),
            activeMenuItem = document.querySelector(`.profile-settings-menu__item.button-theme--dark`),
            activeBlockItem = document.querySelector(`.profile-body__block[data-id="${active}"]`);


        var headerPageMenu = undefined;
        function initSwiper() {
            if (window.innerWidth < 768 && headerPageMenu == undefined) { 
                headerPageMenu = new Swiper(".profile-settings-content", {
                    spaceBetween: 10,
                    slidesPerView: "auto",
                    freeMode: true,
                    freeModeMomentumBounce: false,
                    freeModeMinimumVelocity: 0,
                    centeredSlides: false,
                    breakpoints: {
                        0: {
                            slidesPerView: "auto"
                        }
                    }
                });
                
                headerPageMenu.slideTo(activeMenuItem.dataset.id - 1);
            } else {
                if (headerPageMenu != undefined) {
                    headerPageMenu.destroy();
                }
                headerPageMenu = undefined;
            }
        }

        initSwiper();

        window.addEventListener("resize", function(event) {
            initSwiper();
        });
    </script>')}
{else}
    {'@FILE snippets/Redirect.php' | snippet : [
        'id' => '16'
        'isAuth' => '0'
    ]}
{/if}