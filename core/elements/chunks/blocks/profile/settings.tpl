<div class="login">
    <div class="login-container login-container--wide container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                <h2 class="login-content__header--title">Настройки</h2>
                <div class="login-content__header--subtitle">
                    Пожалуйста укажите полные данные о себе, чтобы сделать 
                    работу таролога более эффективной. 
                </div>
            </div>
            <div class="login-content__body">
                {$errors}
                
                {'!UpdateProfile' | snippet : [
                    'validate' => 'fullname:required, email:required, gender:required, age:required, timezone:required'
                    'placeholderPrefix' => 'upd.'
                    'submitVar' => 'login-updprof-btn'
                ]}

                <div class="login-tpl register">
                    <div class="login-tpl-message">{$_modx->getPlaceholder('upd.error.message')}</div>
                    <div class="login-tpl-content">
                        <form id="settings" class="form login-tpl-content__form login-form" action="/{$_modx->makeUrl($_modx->resource.id)}" method="post">
                            <input type="hidden" name="nospam:blank" value="" />
                            <div class="login-tpl-form__list">
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="fullname">
                                            Как Вас зовут?
                                            <span class="error">{$_modx->getPlaceholder('upd.error.fullname')}</span>
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="fullname" id="fullname" value="{$_modx->getPlaceholder('upd.fullname')}" placeholder="Ваше имя..." required />
                                        <small class="form__error">Заполните поле</small>
                                    </div>
                                </div>
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="email">
                                            E-mail
                                            <span class="error">{$_modx->getPlaceholder('upd.error.email')}</span>
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="email" id="email" value="{$_modx->getPlaceholder('upd.email')}" placeholder="Ваш E-mail..." required />
                                        <small class="form__error">Неверный формат электронной почты</small>
                                    </div>
                                </div>
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="gender">
                                            Ваш пол
                                            <span class="error">{$_modx->getPlaceholder('upd.error.gender')}</span>
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <select class="form__input form__input--select login-tpl-form__item--input" name="gender" id="gender" required>
                                            <option value="0" hidden selected disabled>Выберите</option>
                                            <option value="1" [[+upd.gender:is=`1`:then=`selected`]]>Мужской</option>
                                            <option value="2" [[+upd.gender:is=`2`:then=`selected`]]>Женский</option>
                                        </select>
                                        <small class="form__error">Укажите пол</small>
                                    </div>
                                </div>
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="age">
                                            Сколько Вам лет?
                                            <span class="error">{$_modx->getPlaceholder('upd.error.age')}</span>
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="age" id="age" value="{$_modx->getPlaceholder('upd.age')}" placeholder="18" />
                                        <small class="form__error">Вы должны быть старше 18 лет, для получения услуг</small>
                                    </div>
                                </div>
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="timezone">
                                            Часовой пояс
                                            <span class="error">{$_modx->getPlaceholder('upd.error.timezone')}</span>
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <select class="form__input form__input--select login-tpl-form__item--input" name="timezone" id="timezone" required>
                                            <option value="no" hidden selected disabled>Выберите</option>
                                            {'@FILE snippets/timezones.php' | snippet : [
                                                'current' => $_modx->getPlaceholder('upd.timezone')
                                            ]}
                                        </select>
                                        <small class="form__error">Укажите ваш часовой пояс</small>
                                    </div>
                                </div>

                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left"></div>
                                    <div class="login-tpl-form__item--right display__block">
                                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="submit" name="login-updprof-btn" id="login-updprof-btn" value="Сохранить" />
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>