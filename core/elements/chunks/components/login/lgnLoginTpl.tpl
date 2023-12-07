{set $imaskJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/js/imask.js'
]}
{set $intlTelInputCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/css/intlTelInput.min.css'
]}

{set $imaskJSPreload = '<link rel="preload" as="script" href="'~$imaskJS~'">'}
{set $intlTelInputPreload = '<link rel="preload" as="style" href="'~$intlTelInputCSS~'">'}
{set $intlTelInput = '<link href="'~$intlTelInputCSS~'" rel="stylesheet">'}

{$imaskJSPreload | htmlToHead: true}
{$intlTelInputPreload | htmlToHead: true}
{$intlTelInput | htmlToHead: true}

<div class="login-tpl">
    <div class="login-tpl-message">{$errors}</div>
    <div class="login-tpl-content">
        <form class="form login-tpl-content__form login-form" action="{$_modx->makeUrl($_modx->resource.id)}" method="post">
            <div class="login-tpl-form__list">
                <div class="login-tpl-form__group">
                    <div class="login-tpl-form__group--item">
                        <input id="client" class="form__radio login-tpl-form__item--input" type="radio" name="user-group" value="2" checked />
                        <label for="client" class="form__label login-tpl-form__item--label">
                            Клиент
                        </label>
                    </div>
                    <div class="login-tpl-form__group--item">
                        <input id="tarologist" class="form__radio login-tpl-form__item--input" type="radio" name="user-group" value="3" />
                        <label for="tarologist" class="form__label login-tpl-form__item--label">
                            Астролог
                        </label>
                    </div>
                </div>

                <div class="login-tpl-form__item">
                    <div class="login-tpl-form__item--left">
                        <label class="form__label login-tpl-form__item--label" for="phone">Телефон</label>
                    </div>
                    <div class="login-tpl-form__item--right">
                        <input id="phone" class="form__input form__input--tel login-tpl-form__item--input" type="tel" name="username" placeholder="+7 (000) 000-00-00" required />
                    </div>
                </div>

                <div class="login-tpl-form__item">
                    <div class="login-tpl-form__item--left"></div>
                    <div class="login-tpl-form__item--right">
                        <input id="agreement" class="form__checkbox login-tpl-form__item--input" type="checkbox" name="personal" required />
                        <label for="agreement" class="form__label login-tpl-form__item--label">
                            <div class="form__label--text">Принимаю <a href="/privacy-policy" class="link--theme--mint">условия обработки персональных данных</a></div>
                        </label>
                    </div>
                </div>

                <input class="returnUrl" type="hidden" name="returnUrl" value="{$request_uri}" />
                {$login.recaptcha_html}
                <input class="login-tpl-form__item--input" type="hidden" name="service" value="login" />

                <div class="login-tpl-form__item">
                    <div class="login-tpl-form__item--left"></div>
                    <div class="login-tpl-form__item--right display__block">
                        <input type="hidden" name="action" value="login">
                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="next" value="Дальше" />
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/js/imask.js'
])}

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/js/intlTelInput.js'
])}

{$_modx->regClientScript('<script>
    let phoneField = document.querySelector("#phone"),
        checkboxField = document.querySelector("#agreement");

    let mask = IMask(phoneField, {
        mask: "+{7} (000) 000-00-00"
    });

    window.intlTelInput(phoneField, {
        preferredCountries: ["ru"],
        localizedCountries: { 
            "ru": "Россия"
        }
    });

    function validatePhone(phone){
        let regex = /^(\+7|7|8)?[\s\-]?\(?[489][0-9]{2}\)?[\s\-]?[0-9]{3}[\s\-]?[0-9]{2}[\s\-]?[0-9]{2}$/;
        return regex.test(phone);
    }

    document.querySelector(`input[name="next"]`).addEventListener("click", function () {
        if (!validatePhone(phoneField.value)) {
            phoneField.classList.add("invalid");
        } else {
            phoneField.classList.remove("invalid");
        }

        if (document.querySelector("#agreement:checked") == null) {
            checkboxField.classList.add("invalid");
        } else {
            checkboxField.classList.remove("invalid");
        }

        if (validatePhone(phoneField.value) && document.querySelector("#agreement:checked") != null) {
            document.querySelector("form").submit();
        }
    });

</script>', true)}