<div class="login-tpl">
    <div class="login-tpl-message">{$errors}</div>
    <div class="login-tpl-content">
        <form class="form login-tpl-content__form login-form" action="{$_modx->makeUrl($_modx->resource.id)}" method="post">
            <div class="login-tpl-form__list">
                <div class="login-tpl-form__item">
                    <div class="login-tpl-form__item--left">
                        <label class="form__label login-tpl-form__item--label" for="smsCode">Код</label>
                    </div>
                    <div class="login-tpl-form__item--right">
                        <input id="phone" class="form__input form__input--tel login-tpl-form__item--input" placeholder="Введите код..." type="text" name="smsCode" />
                        <small data-action="sendMessage">
                            Код действителен в течение 2-х минут. Если код вам так и не пришел, нажмите <a href="#" data-action="resendSMS">сюда</a> чтобы его переслать.
                        </small>
                    </div>
                </div>

                <div class="login-tpl-form__item">
                    <div class="login-tpl-form__item--left"></div>
                    <div class="login-tpl-form__item--right display__block">
                        <input type="hidden" name="action" value="login">
                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="submit" name="next" value="Подтвердить" />
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

{$_modx->regClientScript('<script>
    let resendSMS = document.querySelector(`a[data-action="resendSMS"]`);

    resendSMS.addEventListener("click", function (e) {
        let	id_product = 321;
        let qty_product = 2;

        const request = new XMLHttpRequest();
        const url = "/sms";
        const params = `action=login&sendSMSCode=true`

        request.open("POST", url, true);
        request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        request.addEventListener("readystatechange", () => {
            if(request.readyState === 4 && request.status === 200) {
                document.querySelector(`small[data-action="sendMessage"]`).innerHTML = "Код действителен в течение 2-х минут. Код отправлен!";
            }
        });
        
        request.send(params);
        e.preventDefault();
    });

</script>', true)}