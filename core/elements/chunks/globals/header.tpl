<header class="header">
    <div class="container header-container">
        <div class="header-container__block header-block">
            <div class="header-block__logo">
                <a href="/" class="header-block__logo-link">
                    <img class="header-block__logo__img" src="/assets/img/blocks/logo-new.png" alt="">
                </a>
            </div>
            <div class="header-block__menu header-menu">
                <div class="header-menu__burger menu-burger target">
                    <div class="menu-burger__header">
                        <span></span>
                    </div>
                    <nav class="header-menu__nav">
                        <input type="checkbox" id="checkbox" class="header-menu__checkbox">
                        <label for="checkbox" class="header-menu__btn">
                            <div class="header-menu__icon"></div>
                        </label>
                        <div class="header-menu__container">
                            <div class="menu header-menu__list">
                                {'@FILE snippets/pdoTools/pdoMenu.php' | snippet : [
                                    'startId' => '0'
                                    'level' => '1'
                                    'showHidden' => '0'
                                    'sortby' => 'menuindex'
                                    'tplOuter' => '@INLINE {$wrapper}'
                                    'tpl' => '@INLINE   <div class="header-menu__item {$classnames}">
                                                            <a class="header-menu__link" href="/{$link}" {$attributes}>{$menutitle}</a>
                                                        </div>'
                                    'tplParentRow' => ''
                                ]}
                
                                <div class="header-menu__item">
                                    {if !$modx->user->isAuthenticated()}
                                        <a class="header-menu__link" href="/login">
                                            {'@FILE chunks/icons/icon-profile.tpl' | chunk}
                                            <span>Личный кабинет</span>
                                        </a>
                                    {else}
                                        <a class="header-menu__link user-auth" data-menu="header-menu" href="/profile">
                                            {'@FILE chunks/icons/icon-profile.tpl' | chunk}
                                            <span>{$_modx->user.fullname}</span>
                                            {'@FILE chunks/icons/icon-arrow-down.tpl' | chunk}
                                        </a>
                                        <div class="header-menu__dropdown" data-drop="header-menu">
                                            <a href="#" class="header-menu__dropdown--link">
                                                Служба поддержки
                                                <div class="footer-item__link-state"></div>
                                            </a>
                                            {if $_modx->user.extended.usertype == 3}
                                                <a href="/profile/questionnaire" class="header-menu__dropdown--link">
                                                    Анкета
                                                </a>
                                                <a href="/profile/calendar" class="header-menu__dropdown--link">
                                                    Календарь
                                                </a>
                                            {/if}
                                            <a href="/profile/myconsultations" class="header-menu__dropdown--link">
                                                Мои консультации
                                            </a>
                                            <a href="/profile/finances" class="header-menu__dropdown--link">
                                                Финансы
                                            </a>
                                            <a href="/profile/settings" class="header-menu__dropdown--link">
                                                Настройки
                                            </a>
                                            <a href="/qa" class="header-menu__dropdown--link">
                                                Вопрос-ответ
                                            </a>
                                            <a href="/login?action=logout" class="header-menu__dropdown--link">
                                                Выход
                                            </a>
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>

{if $modx->user->isAuthenticated()}
    {$_modx->regClientScript('<script>
        let dropdownLink = document.querySelector(".user-auth");

        dropdownLink.addEventListener("click", function(e) {
            e.preventDefault();
            e.stopPropagation();

            document.querySelector(`[data-drop="${this.dataset.menu}"]`).classList.toggle("show");
        });

        function isVisible(elem) {
            return !!elem && !!( elem.offsetWidth || elem.offsetHeight || elem.getClientRects().length );
        }

        document.addEventListener("click", function(event) {
            if (!event.target.classList.contains("header-menu__dropdown")) {
                document.querySelectorAll("[data-drop]").forEach(element => {
                    if (!element.contains(event.target) && isVisible(element)) {
                        element.classList.remove("show");
                    }
                });
            }
        });

        document.addEventListener("click", function(event) {
            if (!event.target.classList.contains("header-menu__container") && 
                !event.target.classList.contains("header-menu__btn") && 
                !event.target.classList.contains("header-menu__item") &&
                !event.target.classList.contains("header-menu__icon") &&
                !event.target.classList.contains("header-menu__checkbox") &&
                !event.target.classList.contains("header-menu__list") &&
                !event.target.classList.contains("header-menu__link") &&
                !event.target.classList.contains("header-menu__dropdown--link")
            ) {
                event.stopPropagation();
                document.querySelector("#checkbox").checked = false;
            }
        });
    </script>', true)}
{/if}