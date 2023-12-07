<div class="login">
    <div class="preloader">
        <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
            <path fill="currentColor"
                d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
            </path>
        </svg>
    </div>
    <div class="login-container login-container--wide container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                {'@FILE chunks/elements/alerts.tpl' | chunk : [
                    'fixed' => true
                ]}

                <h2 class="login-content__header--title">Настройки</h2>
                <div class="login-content__header--subtitle">
                    Пожалуйста укажите полные данные о себе, чтобы сделать 
                    работу астролога более эффективной. 
                </div>
            </div>
            <div class="login-content__body">
                {$errors}
                
                {'!UpdateProfile' | snippet : [
                    'validate' => 'fullname:required, email:required, gender:required, age:required, timezone:required',
                    'placeholderPrefix' => 'upd.'
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
                                        <small class="form__error">Поле заполнено неверно! Поле должен содержать только буквы</small>
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
                                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="login-updprof-btn" id="login-updprof-btn" value="Сохранить" />
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

{$_modx->regClientScript('<script>
    document.body.classList.add("loaded");

    let submitButton     = document.querySelector(`#login-updprof-btn`),
        fullnameField    = document.querySelector(`#fullname`),
        emailField       = document.querySelector(`#email`),
        genderField      = document.querySelector(`#gender`),
        ageField         = document.querySelector(`#age`),
        timezoneField    = document.querySelector(`#timezone`),
        isValidFormArray = [true, true, true, true, true]; // Check errors by each field

    // isValid Function
    function isValid(field, id) {
        document.body.classList.add("loaded");
        field.classList.remove("invalid");
        isValidFormArray[id] = true;
    }

    // Validate Email
    function validateEmail(email) {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }

    // Validate Fullname by Only String
    function validateFullname(name) {
        const re = /^[A-Za-zА-Яа-яЁё ]+$/i;
        return re.test(String(name).toLowerCase());
    }

    submitButton.addEventListener("click", function () {
        document.body.classList.remove("loaded");

        // Fullname Field Check
        if (!validateFullname(fullnameField.value)) {
            fullnameField.classList.add("invalid");
            isValidFormArray[0] = false;
        } else {
            isValid(fullnameField, 0);
        }

        // Email Field Check
        if (!validateEmail(emailField.value)) {
            emailField.classList.add("invalid");
            isValidFormArray[1] = false;
        } else {
            isValid(emailField, 1);
        }

        // Gender Field Check
        if (genderField.value === "" || genderField.value === "no") {
            genderField.classList.add("invalid");
            isValidFormArray[2] = false;
        } else {
            isValid(genderField, 2);
        }

        // Age Field Check
        if (Number(ageField.value) < 18) {
            ageField.classList.add("invalid");
            isValidFormArray[3] = false;
        } else {
            isValid(ageField, 3);
        }

        // Timezone Field Check
        if (timezoneField.value === "" || timezoneField.value === "no") {
            timezoneField.classList.add("invalid");
            isValidFormArray[4] = false;
        } else {
            isValid(timezoneField, 4);
        }
        
        if (isValidFormArray.includes(false)) {
            alerts({state: "error", message: "Ошибка в сохранении профиля!<br>Проверьте правильность заполнения!"});
        } else {
            alerts({state: "success", message: "Успешное сохранение профиля!<br>Страница будет перезагружена!"});
            
            setTimeout(function () {
                document.forms.settings.submit();
            }, 1500);
        }
    });
</script>')}