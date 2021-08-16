{set $imaskJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
]}

{set $imaskJSPreload = '<link rel="preload" as="script" href="'~$imaskJS~'">'}

{$imaskJSPreload | htmlToHead: true}

<div class="login-tpl register">
    <div class="login-tpl-message">{$reg.error.message}</div>
    <div class="login-tpl-content">
        {set $sessionUsername = '@FILE snippets/session.php' | snippet : [
            'name' => 'username'
        ]}
        {set $sessionPassword = '@FILE snippets/session.php' | snippet : [
            'name' => 'password'
        ]}
        {set $sessionUserGroup = '@FILE snippets/session.php' | snippet : [
            'name' => 'userGroup'
        ]}
        {set $cardInfo = $_modx->config['Reg.CardInfo']}

        <form id="register" class="form login-tpl-content__form login-form" action="/{$_modx->makeUrl($_modx->resource.id)}" method="post">
            <input type="hidden" name="nospam:blank" value="" />           
            <div class="login-tab tab active" data-id="1" data-parent="1" type-form="registration">
                <div class="login-tpl-form__list">
                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left">
                            <label class="form__label login-tpl-form__item--label" for="fullname">
                                Как Вас зовут?
                                <span class="error">{$reg.error.fullname}</span>
                            </label>
                        </div>
                        <div class="login-tpl-form__item--right">
                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="fullname" id="fullname" value="{$fullname}" placeholder="Ваше имя..." required />
                            <small class="form__error">Заполните поле</small>
                        </div>
                    </div>
                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left">
                            <label class="form__label login-tpl-form__item--label" for="email">
                                E-mail
                                <span class="error">{$reg.error.email}</span>
                            </label>
                        </div>
                        <div class="login-tpl-form__item--right">
                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="email" id="email" value="{$email}" placeholder="Ваш E-mail..." required />
                            <small class="form__error">Неверный формат электронной почты</small>
                        </div>
                    </div>
                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left">
                            <label class="form__label login-tpl-form__item--label" for="gender">
                                Ваш пол
                                <span class="error">{$reg.error.gender}</span>
                            </label>
                        </div>
                        <div class="login-tpl-form__item--right">
                            <select class="form__input form__input--select login-tpl-form__item--input" name="gender" id="gender" required>
                                <option value="0" hidden selected disabled>Выберите</option>
                                <option value="1">Мужской</option>
                                <option value="2">Женский</option>
                            </select>
                            <small class="form__error">Укажите пол</small>
                        </div>
                    </div>
                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left">
                            <label class="form__label login-tpl-form__item--label" for="age">
                                Сколько Вам лет?
                                <span class="error">{$reg.error.age}</span>
                            </label>
                        </div>
                        <div class="login-tpl-form__item--right">
                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="age" id="age" value="{$age}" placeholder="18" />
                            <small class="form__error">Вы должны быть старше 18 лет, для получения услуг</small>
                        </div>
                    </div>
                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left">
                            <label class="form__label login-tpl-form__item--label" for="timezone">
                                Часовой пояс
                                <span class="error">{$reg.error.timezone}</span>
                            </label>
                        </div>
                        <div class="login-tpl-form__item--right">
                            <select class="form__input form__input--select login-tpl-form__item--input" name="timezone:required" id="timezone" required>
                                <option value="no" hidden selected disabled>Выберите</option>
                                {'@FILE snippets/timezones.php' | snippet}
                            </select>
                            <small class="form__error">Укажите ваш часовой пояс</small>
                        </div>
                    </div>

                    <input type="hidden" name="phone" value="{$sessionUsername}" />
                    <input type="hidden" name="password" value="{$sessionPassword}" />
                    <input type="hidden" name="password_confirm" value="{$sessionPassword}" />
                    <input type="hidden" name="usertype" value="{$sessionUserGroup}">

                    {if !$cardInfo}
                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left"></div>
                            <div class="login-tpl-form__item--right">
                                <input id="agreement" class="form__checkbox login-tpl-form__item--input" type="checkbox" name="personal" required />
                                <label for="agreement" class="form__label login-tpl-form__item--label">
                                    <div class="form__label--text">Принимаю <a href="/privacy-policy" class="link--theme--mint">условия обработки персональных данных</a></div>
                                </label>
                            </div>
                        </div>
                    {/if}

                    <div class="login-tpl-form__item">
                        <div class="login-tpl-form__item--left"></div>
                        <div class="login-tpl-form__item--right display__block">
                            {if $cardInfo}
                                <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="next" data-id="2" data-parent="1" type-form="bank" value="Следующий шаг" />
                            {else}
                                <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="submitReg" value="Далее" />
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
            
            {if $cardInfo}
                <div class="login-tab tab" data-id="2" data-parent="1" type-form="bank">
                    <div class="login-tpl-form__list">
                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left">
                                <label class="form__label login-tpl-form__item--label" for="cardname">
                                Имя владельца карты*
                                    <span class="error">{$reg.error.cardname}</span>
                                </label>
                            </div>
                            <div class="login-tpl-form__item--right">
                                <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="cardname" id="cardname" value="{$cardname}" placeholder="Ваше имя..." required />
                                <small class="form__error">Укажите имя держателя карты</small>
                            </div>
                        </div>
                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left">
                                <label class="form__label login-tpl-form__item--label" for="creditnumber">
                                    Номер кредитной карты *
                                    <span class="error">{$reg.error.creditnumber}</span>
                                </label>
                            </div>
                            <div class="login-tpl-form__item--right">
                                <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="creditnumber" id="creditnumber" value="{$creditnumber}" placeholder="0000 1234 4567 8900" required />
                                <small class="form__error">Укажите номер карты</small>
                            </div>
                        </div>
                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left">
                                <label class="form__label login-tpl-form__item--label" for="datefinished">
                                    Дата окончания срока действия *
                                    <span class="error">{$reg.error.datefinished}</span>
                                </label>
                            </div>
                            <div class="login-tpl-form__item--right">
                                <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="datefinished" id="datefinished" value="{$datefinished}" placeholder="ММ/ГГ" required />
                                <small class="form__error">Укажите дату окончания срока действия карты</small>
                            </div>
                        </div>
                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left">
                                <label class="form__label login-tpl-form__item--label" for="cvc">
                                    CVC-код *
                                    <span class="error">{$reg.error.cvc}</span>
                                </label>
                            </div>
                            <div class="login-tpl-form__item--right">
                                <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="cvc" id="cvc" value="{$age}" placeholder="123" required />
                                <small class="form__error">Укажите CVC-код</small>
                            </div>
                        </div>

                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left"></div>
                            <div class="login-tpl-form__item--right">
                                <input id="agreement" class="form__checkbox login-tpl-form__item--input" type="checkbox" name="personal" required />
                                <label for="agreement" class="form__label login-tpl-form__item--label">
                                    <div class="form__label--text">Принимаю <a href="#">условия обработки персональных данных</a></div>
                                </label>
                            </div>
                        </div>

                        <div class="login-tpl-form__item">
                            <div class="login-tpl-form__item--left"></div>
                            <div class="login-tpl-form__item--right flex-direction--row display__block">
                                <input class="button button-size--normal button-theme--dark login-tpl-form__item--button" type="button" name="prev" data-id="1" data-parent="1" type-form="registration" value="Назад" />
                                <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="submitReg" value="Далее" />
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
        </form>
    </div>
</div>

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
])}

{$_modx->regClientScript('<script>
    let cardInfo = '~ $cardInfo ~';

    if (cardInfo) {
        let dateFinished = IMask(document.querySelector("#datefinished"), {
                mask: "00/00"
            }),
            cvcCode = IMask(document.querySelector("#cvc"), {
                mask: "000"
            }),
            creditNumber = IMask(document.querySelector("#creditnumber"), {
                mask: "0000 0000 0000 0000"
            });
    }
    
    let steps = document.querySelectorAll("input[data-id]")
        headerStep = document.querySelectorAll(".login-steps-content__step"),
        tabs = document.querySelectorAll(`.login-tab`),
        title = document.querySelector(".login-content__header--title"),
        subtitle = document.querySelector(".login-content__header--subtitle"),
        activeStep = 1,
        headers = [{
            title: "Регистрация",
            subtitle: "Давайте знакомиться!"
        }, {
            title: "Привязка карты",
            subtitle: "Для завершения регистрации пожалуйста прикрепите банковскую карту к аккаунту"
        }],
        fullnameField = document.querySelector("#fullname"),
        genderField = document.querySelector("#gender"),
        emailField = document.querySelector("#email"),
        ageField = document.querySelector("#age"),
        timezoneField = document.querySelector("#timezone"),
        cardnameField = document.querySelector("#cardname"),
        creditnumberField = document.querySelector("#creditnumber"),
        datefinishedField = document.querySelector("#datefinished"),
        cvcField = document.querySelector("#cvc"),
        checkboxField = document.querySelector("#agreement");

    function validateEmail(email) {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }

    // Validate Fullname by Only String
    function validateFullname(name) {
        const re = /^[A-Za-zА-Яа-яЁё ]+$/i;
        return re.test(String(name).toLowerCase());
    }

    steps.forEach(element => {
        element.addEventListener("click", function () {
            if (!validateFullname(fullnameField.value)) {
                fullnameField.classList.add("invalid");
            } else {
                fullnameField.classList.remove("invalid");
            }

            if (genderField.value == "0") {
                genderField.classList.add("invalid");
            } else {
                genderField.classList.remove("invalid");
            }

            if (!validateEmail(emailField.value)) {
                emailField.classList.add("invalid");
            } else {
                emailField.classList.remove("invalid");
            }

            if (Number(ageField.value) < 18) {
                ageField.classList.add("invalid");
            } else {
                ageField.classList.remove("invalid");
            }

            if (timezoneField.value == "no") {
                timezoneField.classList.add("invalid");
            } else {
                timezoneField.classList.remove("invalid");
            }

            if (validateFullname(fullnameField.value) && 
                validateEmail(emailField.value) &&
                genderField.value !== "0" &&
                Number(ageField.value) >= 18 &&
                timezoneField.value !== "no") 
            {
                activeStep = Number(this.dataset.id);
                title.innerHTML = headers[Number(this.dataset.id) - 1].title;
                subtitle.innerHTML = headers[Number(this.dataset.id) - 1].subtitle;

                headerStep.forEach(elem => {
                    elem.classList.remove("active");
                });
                document.querySelector(`.login-steps-content__step[data-id="${this.dataset.id}"]`).classList.add("active");

                tabs.forEach(elem => {
                    elem.classList.remove("active");
                });
                document.querySelector(`.login-tab[data-id="${this.dataset.id}"]`).classList.add("active");
            } else {
                activeStep = Number(this.dataset.id);
            }
        });
    });

    document.querySelector(`input[name="submitReg"]`).addEventListener("click", function () {
        if (cardInfo) {
            if (cardnameField.value == "") {
                cardnameField.classList.add("invalid");
            } else {
                cardnameField.classList.remove("invalid");
            }

            if (creditnumberField.value.length !== 19) {
                creditnumberField.classList.add("invalid");
            } else {
                creditnumberField.classList.remove("invalid");
            }

            if (datefinishedField.value.length !== 5) {
                datefinishedField.classList.add("invalid");
            } else {
                datefinishedField.classList.remove("invalid");
            }

            if (cvcField.value.length !== 3) {
                cvcField.classList.add("invalid");
            } else {
                cvcField.classList.remove("invalid");
            }

            if (activeStep === 2 && 
                cardnameField.value !== "" &&
                creditnumberField.value.length === 19 &&
                datefinishedField.value.length === 5 &&
                cvcField.value.length === 3 &&
                document.querySelector("#agreement:checked") !== null) 
            {
                document.querySelector("#register").submit();
            }
        } else {
            if (!validateFullname(fullnameField.value)) {
                fullnameField.classList.add("invalid");
            } else {
                fullnameField.classList.remove("invalid");
            }

            if (genderField.value == "0") {
                genderField.classList.add("invalid");
            } else {
                genderField.classList.remove("invalid");
            }

            if (!validateEmail(emailField.value)) {
                emailField.classList.add("invalid");
            } else {
                emailField.classList.remove("invalid");
            }

            if (Number(ageField.value) < 18) {
                ageField.classList.add("invalid");
            } else {
                ageField.classList.remove("invalid");
            }

            if (timezoneField.value == "no") {
                timezoneField.classList.add("invalid");
            } else {
                timezoneField.classList.remove("invalid");
            }

            if (!checkboxField.checked) {
                checkboxField.classList.add("invalid");
            } else {
                checkboxField.classList.remove("invalid");
            }

            if (validateFullname(fullnameField.value) && 
                validateEmail(emailField.value) &&
                genderField.value !== "0" &&
                Number(ageField.value) >= 18 &&
                timezoneField.value !== "no" &&
                document.querySelector("#agreement:checked") !== null) 
            {
                document.querySelector("#register").submit();
            }
        }
    });
</script>', true)}