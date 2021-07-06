{set $imaskJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
]}
{set $nativeModalsJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/native-modals.js'
]}
{set $nativeModalsCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/native-modals.css'
]}

{set $imaskJSPreload = '<link rel="preload" as="script" href="'~$imaskJS~'">'}
{set $nativeModalsJSPreload = '<link rel="preload" as="script" href="'~$nativeModalsJS~'">'}
{set $nativeModalsCSSPreload = '<link rel="preload" as="style" href="'~$nativeModalsCSS~'">'}
{set $nativeModalsCSSLink = '<link href="'~$nativeModalsCSS~'" rel="stylesheet">'}

{$imaskJSPreload | htmlToHead: true}
{$nativeModalsJSPreload | htmlToHead: true}
{$nativeModalsCSSPreload | htmlToHead: true}
{$nativeModalsCSSLink | htmlToHead: true}

<div class="login">
    <div class="login-container login-container--full container">
        <div class="login-container__content login-content">
            <div class="preloader">
                <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                    <path fill="currentColor"
                        d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                    </path>
                </svg>
            </div>
            <div class="login-content__header finances-form">
                {'@FILE chunks/elements/alerts.tpl' | chunk : [
                    'fixed' => true
                ]}
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
                    'postHooks' => 'encryptField'
                ]}

                {set $decryptCVC = '@FILE snippets/decryptField.php' | snippet : [
                    'input' => $_modx->getPlaceholder('upd.cvc')
                ]}

                <div class="login-finances__tab login-tab tab" data-id="1">
                    <div class="login-tpl finances-form">
                        <div class="login-tpl-message">{$_modx->getPlaceholder('upd.error.message')}</div>
                        <div class="login-tpl-content">
                            <form id="finances" class="form login-tpl-content__form login-form" action="/{$_modx->makeUrl($_modx->resource.id)}" method="post">
                                <input type="hidden" name="nospam:blank" value="" />
                                <input type="hidden" id="idUser" name="idUser" value="{$_modx->user.id}" />
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
                                            <input type="password" class="form__input form__input--tel login-tpl-form__item--input" name="cvc" id="cvc" value="{$decryptCVC}" placeholder="123" required />
                                            <small class="form__error">Укажите CVC-код</small>
                                        </div>
                                    </div>
                
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left"></div>
                                        <div class="login-tpl-form__item--right display__block">
                                            <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" data-nmodal="financesSecure" data-nmodal-size="large" name="login-updfin-btn" id="login-updfin-btn" value="Сохранить" />
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


<div id="financesSecure" class="nModal">
    <form id="financesSecure-form" action="">
        <div class="nModal-header">
            <div>
                <div class="nModal-header__title">Подтвердите привязку карты</div>
            </div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body">
            <iframe src="" width="100%" height="720" frameborder="0"></iframe>
        </div>
    </form>
</div>

{$_modx->regClientScript($nativeModalsJS)}

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
])}

{$_modx->regClientScript('<script>
    document.addEventListener("DOMContentLoaded", function () {        
        nModal.init({
            watch: true,
            backdrop: true,
            alerts: {
                init: true,
                msg: "Привязка карты отменена"
            }
        });
    });

    let idUserField = document.querySelector("#idUser"),
        cardholderField = document.querySelector("#cardname"),
        dateFinishedField = document.querySelector("#datefinished"),
        cvcField = document.querySelector("#cvc"),
        creditNumberField = document.querySelector("#creditnumber"),
        dateFinished = IMask(dateFinishedField, {
            mask: "00/00"
        }),
        cvcCode = IMask(cvcField, {
            mask: "000"
        }),
        creditNumber = IMask(creditNumberField, {
            mask: "0000 0000 0000 0000"
        }),
        financesCheckboxes = document.querySelectorAll(`.form__radio[name="financestype"]`),
        financestypeChecked = document.querySelector(`.form__radio[name="financestype"]:checked`),
        financesTabs = document.querySelectorAll(".login-finances__tab"),
        submitFormButton = document.querySelector("#login-updfin-btn"),
        modalFormFrame = document.querySelector("#financesSecure-form .nModal-body iframe");

    document.body.classList.add("loaded");

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

    submitFormButton.addEventListener("click", function() {
        document.body.classList.remove("loaded");
        let formData = new FormData(document.forms.finances),
            xhr = new XMLHttpRequest(),
            newXhr = new XMLHttpRequest();

        xhr.open("POST", "/assets/php/payment.php?action=createPayment&type=checkNewCard", false);
        xhr.send(formData);

        if (xhr.status != 200) {
            alerts({state: "error", message: "XMLHttpRequest status not 200"});
        } else {
            console.log(xhr.responseText);
            if (xhr.responseText !== "false") {
                let response = JSON.parse(xhr.responseText);
                modalFormFrame.setAttribute("src", response.confirmation["confirmation_url"]);

                var $modalContainer = document.querySelector("#nModal-container");
                var newObserver = new MutationObserver(function(mutationsList) {
                    for (var mutation of mutationsList) {
                        if (mutation.type == "attributes") {
                            if (!mutation.target.classList.contains("active") && 
                                !mutation.target.classList.contains("hidden")
                            ) {
                                newXhr.open("POST", "/assets/php/payment.php?action=createRefund", false);
                                let formDataNew = new FormData();
                                console.log(response.id, response.amount.value);
                                formDataNew.append("paymentID", response.id);
                                formDataNew.append("paymentValue", response.amount.value);
                                newXhr.send(formDataNew);

                                if (newXhr.status != 200) {} 
                                else {
                                    document.body.classList.add("loaded");
                                    alerts({state: "success", message: "Карта успешно привязана! Сейчас страница перезагрузится"});

                                    setTimeout(function () {
                                        document.forms.finances.submit();
                                    }, 1500);
                                }
                            }
                        }
                    }
                });
                
                newObserver.observe($modalContainer, {
                    "attributes": true
                });
            } else {
                document.body.classList.add("loaded");
                modalFormFrame.setAttribute("src", "http://voski.loc/payment-status?vnumber=" + creditNumberField.value.replaceAll(" ", ""));
            }
        }
    });

    function closeModal() {
        nModal.close();
        document.body.classList.add("loaded");
    }
</script>', true)}