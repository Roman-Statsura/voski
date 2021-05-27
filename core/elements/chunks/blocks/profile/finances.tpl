{set $imaskJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
]}

{set $imaskJSPreload = '<link rel="preload" as="script" href="'~$imaskJS~'">'}

{$imaskJSPreload | htmlToHead: true}

<div class="login">
    <div class="login-container login-container--full container">
        <div class="login-container__content login-content">
            <div class="login-content__header finances-form">
                <h2 class="login-content__header--title">Финансы</h2>
                <div class="login-content__header--subtitle">
                    Здесь отображаются данные о вашей прикрепленной карте. А так же информация о совершенных вами платежах
                </div>
            </div>
            <div class="login-content__body">
                <div class="login-tpl-form__group">
                    <div class="login-tpl-form__group--item">
                        <input id="card" class="form__radio login-tpl-form__item--input" type="radio" name="financestype" value="1" checked />
                        <label for="card" class="form__label login-tpl-form__item--label">
                            Карта
                        </label>
                    </div>
                    <div class="login-tpl-form__group--item">
                        <input id="payments" class="form__radio login-tpl-form__item--input" type="radio" name="financestype" value="2" />
                        <label for="payments" class="form__label login-tpl-form__item--label">
                            Платежи 
                        </label>
                    </div>
                </div>

                {$errors}
                
                {'!UpdateProfile' | snippet : [
                    'validate' => ''
                    'placeholderPrefix' => 'upd.'
                    'submitVar' => 'login-updprof-btn'
                ]}

                <div class="login-finances__tab login-tab tab" data-id="1">
                    <div class="login-tpl finances-form">
                        <div class="login-tpl-message">{$_modx->getPlaceholder('upd.error.message')}</div>
                        <div class="login-tpl-content">
                            <form id="settings" class="form login-tpl-content__form login-form" action="/{$_modx->makeUrl($_modx->resource.id)}" method="post">
                                <input type="hidden" name="nospam:blank" value="" />
                                <div class="login-tpl-form__list">
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left">
                                            <label class="form__label login-tpl-form__item--label" for="cardname">
                                            Имя владельца карты*
                                            </label>
                                        </div>
                                        <div class="login-tpl-form__item--right">
                                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="cardname" id="cardname" value="{$_modx->getPlaceholder('upd.cardname')}" placeholder="Ваше имя..." required />
                                            <small class="form__error">Укажите имя держателя карты</small>
                                        </div>
                                    </div>
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left">
                                            <label class="form__label login-tpl-form__item--label" for="creditnumber">
                                                Номер кредитной карты *
                                            </label>
                                        </div>
                                        <div class="login-tpl-form__item--right">
                                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="creditnumber" id="creditnumber" value="{$_modx->getPlaceholder('upd.creditnumber')}" placeholder="0000 1234 4567 8900" required />
                                            <small class="form__error">Укажите номер карты</small>
                                        </div>
                                    </div>
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left">
                                            <label class="form__label login-tpl-form__item--label" for="datefinished">
                                                Дата окончания срока действия *
                                            </label>
                                        </div>
                                        <div class="login-tpl-form__item--right">
                                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="datefinished" id="datefinished" value="{$_modx->getPlaceholder('upd.datefinished')}" placeholder="ММ/ГГ" required />
                                            <small class="form__error">Укажите дату окончания срока действия карты</small>
                                        </div>
                                    </div>
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left">
                                            <label class="form__label login-tpl-form__item--label" for="cvc">
                                                CVC-код *
                                            </label>
                                        </div>
                                        <div class="login-tpl-form__item--right">
                                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="cvc" id="cvc" value="{$_modx->getPlaceholder('upd.cvc')}" placeholder="123" required />
                                            <small class="form__error">Укажите CVC-код</small>
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
                <div class="login-finances__tab login-tab tab" data-id="2">
                    <div class="table-flex">
                        <div class="table-flex--row table-flex--head">
                            <div class="table-flex--col">Дата</div>
                            <div class="table-flex--col">Получатель</div>
                            <div class="table-flex--col">Описание</div>
                            <div class="table-flex--col">Статус</div>
                            <div class="table-flex--col">Сумма</div>
                            <div class="table-flex--col">Чек</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
])}

{$_modx->regClientScript('<script>
    let dateFinished = IMask(document.querySelector("#datefinished"), {
            mask: "00/00"
        }),
        cvcCode = IMask(document.querySelector("#cvc"), {
            mask: "000"
        }),
        creditNumber = IMask(document.querySelector("#creditnumber"), {
            mask: "0000 0000 0000 0000"
        }),
        financesCheckboxes = document.querySelectorAll(`.form__radio[name="financestype"]`),
        financestypeChecked = document.querySelector(`.form__radio[name="financestype"]:checked`),
        financesTabs = document.querySelectorAll(".login-finances__tab");

    function changeTab(checkbox) {
        financesTabs.forEach(element => {
            element.classList.remove("active");

            if (element.dataset.id === checkbox.value) {
                element.classList.add("active");
            }
        });
    }

    changeTab(financestypeChecked);

    financesCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", function() {
            changeTab(checkbox);
        });
    });
</script>', true)}