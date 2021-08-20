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
    <div class="preloader">
        <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
            <path fill="currentColor"
                d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
            </path>
        </svg>
    </div>
    <div class="login-container login-container--100 container">
        <div class="login-container__content login-content">
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
                                            <small class="form__error">Проверьте правильность заполнения</small>
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
                                            <small class="form__error">Укажите корректный номер карты</small>
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
                                            <small class="form__error">Укажите корректную дату окончания срока действия карты</small>
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
                                            <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" data-nmodal-callback="financesSecure" data-nmodal="financesSecure" data-nmodal-size="large" name="login-updfin-btn" id="login-updfin-btn" value="Сохранить" />
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="login-finances__tab login-tab tab" data-id="2">
                    {if $_modx->user.extended.usertype == 3}
                        {set $userQuestResourse = '@FILE snippets/findUserAndReview.php' | snippet : [
                            'id' => $_modx->getPlaceholder('upd.internalKey')
                        ]}
                    {else}
                        {set $userQuestResourse = $_modx->getPlaceholder('upd.internalKey')}
                    {/if}

                    {set $consultations = '!pdoResources' | snippet : [
                        'parents' => 36,
                        'sortby' => 'consultDatetime',
                        'sortdir' => 'ASC',
                        'includeTVs' => 'consultDatetime, consultIDClient, consultIDTarot, consultZoomID, consultZoomLink, consultZoomStartLink, 
                                        consultDesc, consultStatusSession, consultDuration, consultSended, consultPaymentID',
                        'includeContent' => '1',
                        'return' => 'json',
                        'limit' => 0
                    ] | json_decode : true}

                    <div class="table-flex table-consultation">
                        <div class="table-flex--row table-flex--head">
                            <div class="table-flex--col">Дата</div>
                            <div class="table-flex--col">{if $_modx->user.extended.usertype == 3}Отправитель{else}Получатель{/if}</div>
                            <div class="table-flex--col">Описание</div>
                            <div class="table-flex--col">Статус</div>
                            <div class="table-flex--col">Сумма</div>
                            <div class="table-flex--col">Чек</div>
                        </div>
                        {set $innerCount = 0}
                        {if count($consultations) > 0}
                            {foreach $consultations as $key => $consultItem}
                                {if ($_modx->user.extended.usertype == 3 && $consultItem['tv.consultIDTarot'] == $userQuestResourse) || ($_modx->user.extended.usertype == 2 && $consultItem['tv.consultIDClient'] == $userQuestResourse)}
                                    {if $consultItem['tv.consultPaymentID'] != ""}
                                        {set $paymentInfo = '@FILE snippets/getPaymentInfo.php' | snippet : [
                                            'paymentID' => $consultItem['tv.consultPaymentID']
                                        ]}
                                        {if ($_modx->user.extended.usertype == 2 && ($paymentInfo["statusCode"] == "waiting_for_capture" || $paymentInfo["statusCode"] == "succeeded")) ||
                                            ($_modx->user.extended.usertype == 3 && $paymentInfo["statusCode"] == "succeeded")}
                                            {set $innerCount = $innerCount + 1}
                                            
                                            <div class="login-finances__tab login-tab tab" data-id="2">
                                                {if $consultItem.published}
                                                    {if $consultItem['tv.consultStatusSession'] != 3}
                                                        {if $_modx->user.extended.usertype == 3}
                                                            {set $userFullname = '@FILE snippets/getUserNameByID.php' | snippet : [
                                                                'id' => $consultItem['tv.consultIDClient']
                                                                'field' => 'fullname'
                                                            ]}
                                                        {else}
                                                            {set $userFullname = $consultItem['tv.consultIDTarot'] | resource : 'pagetitle'}
                                                        {/if}

                                                        <div class="table-flex--row table-flex--body nModal-button" data-cnsid="{$key}" data-consultation="cnsid-{$consultItem.id}" data-name="{$userFullname}" data-payment="{$consultItem['tv.consultPaymentID']}" data-nmodal-callback="paymentInfo" data-nmodal="paymentInfo" data-nmodal-size="large">
                                                            <div class="table-flex--item">
                                                                <div class="table-flex--col">{$consultItem['tv.consultDatetime'] | date: 'd.m.Y H:i'}</div>
                                                                <div class="table-flex--col">{$userFullname}</div>
                                                                <div class="table-flex--col consult-text">
                                                                    {$paymentInfo["description"]}
                                                                </div>
                                                                <div class="table-flex--col">
                                                                    <span class="table-consultation__status {if $paymentInfo['status'] == 'Оплачен'}table-consultation__status--green{/if}{if $paymentInfo['status'] == 'Отменен'}table-consultation__status--red{/if}">
                                                                        {$paymentInfo["status"]}
                                                                    </span>
                                                                </div>
                                                                <div class="table-flex--col table-consultation__duration">
                                                                    {$paymentInfo["price"]} Р
                                                                </div>
                                                                
                                                                <div class="table-flex--col">
                                                                    <a href="" download="">
                                                                        {'@FILE chunks/icons/icon-download.tpl' | chunk}
                                                                    </a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    {/if}
                                                {/if}
                                            </div>
                                        {/if}
                                    {/if}
                                {/if}
                            {/foreach}
                            {if $innerCount == 0}
                                <div class="table-flex--row table-flex--body">
                                    <div class="table-flex--col table-flex--col--full">Вы еще не проводили оплату</div>
                                </div>
                            {/if}
                        {else}
                            <div class="table-flex--row table-flex--body">
                                <div class="table-flex--col table-flex--col--full">Вы еще не проводили оплату</div>
                            </div>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="financesSecure" class="nModal">
    <form id="financesSecure-form" action="">
        <div class="preloader">
            <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                </path>
            </svg>
        </div>
        <div class="nModal-header">
            <div>
                <div class="nModal-header__title">Подтвердите привязку карты</div>
            </div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body">
            <iframe src="" width="100%" height="400" frameborder="0"></iframe>
        </div>
    </form>
</div>

<div id="paymentInfo" class="nModal">
    <form id="paymentInfo-form" action="">
        <div class="preloader">
            <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                </path>
            </svg>
        </div>
        <div class="nModal-header">
            <div>
                <div class="nModal-header__title">Чек об оплате</div>
            </div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body"></div>
        <div class="nModal-buttons"></div>
    </form>
</div>

{$_modx->regClientScript($nativeModalsJS)}

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/imask.js'
])}

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/paymentReasonError.js'
])}

{$_modx->regClientScript('<script>
    document.addEventListener("DOMContentLoaded", function () {  
        document.body.classList.add("loaded");

        nModal.init({
            watch: true,
            backdrop: true,
            alerts: {
                init: false,
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
        isValidFormArray = [true, true, true, true];

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

    function paymentInfo(formElement, event) {
        document.body.classList.remove("loaded");

        let formData = new FormData(),
            xhr = new XMLHttpRequest(),
            paymentID = formElement.dataset.payment,
            paymentModalForm = event.querySelector(".nModal-body");

        formData.append("paymentID", paymentID);
        xhr.open("POST", "/assets/php/payment.php?action=getReceipts", true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState != 4) return;
            if (xhr.status === 200) {
                document.body.classList.add("loaded");
                let response = JSON.parse(xhr.responseText);

                if (response.status === "succeeded") {
                    let modalDiv = `
                        <div class="nModal-body__list">
                            <div class="nModal-body__item">
                                <div class="nModal-body__record">Дата оплаты:</div>
                                <div class="nModal-body__record">${response.formattedDate}</div>
                            </div>
                            <div class="nModal-body__item flex-direction--column">
                                <div class="nModal-body__record">Описание:</div>
                                <div class="nModal-body__record">${response.items[0].description}</div>
                            </div>
                            <div class="nModal-body__item">
                                <div class="nModal-body__record">Стоимость:</div>
                                <div class="nModal-body__record">${Number(response.items[0].amount.value).toFixed(0)} руб</div>
                            </div>
                            <div class="nModal-body__item">
                                <div class="nModal-body__record">Номер фискального документа:</div>
                                <div class="nModal-body__record">${response.fiscal_document_number}</div>
                            </div>
                            <div class="nModal-body__item">
                                <div class="nModal-body__record">Номер фискального накопителя:</div>
                                <div class="nModal-body__record">${response.fiscal_storage_number}</div>
                            </div>
                            <div class="nModal-body__item">
                                <div class="nModal-body__record">Фискальный признак:</div>
                                <div class="nModal-body__record">${response.fiscal_attribute}</div>
                            </div>
                        </div>
                    `;

                    paymentModalForm.innerHTML = modalDiv;
                } else {
                    exceptionError("Ошибка получения чека с кассы!");
                }
            } else {
                exceptionError("Receipt Request status not 200");
            }
        }
        xhr.send(formData);
    }

    // Luhn Algorithm
    function luhnAlgorithm(digits) {
        let sum = 0;

        for (let i = 0; i < digits.length; i++) {
            let cardNum = parseInt(digits[i]);

            if (i % 2 === 0) {
                cardNum = cardNum * 2;

                if (cardNum > 9) {
                    cardNum = cardNum - 9;
                }
            }

            sum += cardNum;
        }

        return sum % 10 === 0;
    }

    // Validate Fullname by Only String
    function validateCardholder(name) {
        const re = /^[A-Za-z ]+$/i;
        return re.test(String(name).toLowerCase());
    }

    // Validate Fullname by Only String
    function validateCVC(code) {
        const re = /^[0-9]{3}$/i;
        return re.test(String(code).toLowerCase());
    }

    // isValid Function
    function isValid(field, id) {
        document.body.classList.add("loaded");
        field.classList.remove("invalid");
        isValidFormArray[id] = true;
    }

    function financesSecure(formElement, event) {
        document.body.classList.remove("loaded");

        // Fullname Field Check
        if (!validateCardholder(cardholderField.value)) {
            cardholderField.classList.add("invalid");
            isValidFormArray[0] = false;
        } else {
            isValid(cardholderField, 0);
        }

        // Credit Card Number Field Check by Luhn Algorithm
        if (!luhnAlgorithm(creditNumberField.value.replaceAll(" ", ""))) {
            creditNumberField.classList.add("invalid");
            isValidFormArray[1] = false;
        } else {
            isValid(creditNumberField, 1);
        }

        // Date Finished Field Check
        let dateFinishedSplit = dateFinishedField.value.split("/"),
            currentDate       = new Date(),
            dateFinishedMonth = Number(dateFinishedSplit[0]),
            dateFinishedYear  = Number("20" + dateFinishedSplit[1]);

        if (
            (dateFinishedMonth <= 0 || dateFinishedMonth > 12) || 
            (dateFinishedYear < currentDate.getFullYear()) ||
            ((dateFinishedMonth < currentDate.getMonth() + 1) && (dateFinishedYear <= currentDate.getFullYear()))
        ) {
            dateFinishedField.classList.add("invalid");
            isValidFormArray[2] = false;
        } else {
            isValid(dateFinishedField, 2);
        }

        // CVC Field Check
        if (!validateCVC(cvcField.value)) {
            cvcField.classList.add("invalid");
            isValidFormArray[3] = false;
        } else {
            isValid(cvcField, 3);
        }

        if (isValidFormArray.includes(false)) {
            exceptionError("Ошибка заполнения формы!<br>Проверьте заполненность формы!");
        } else {
            let modalFormFrame = event.querySelector(".nModal-body iframe"),
                formData = new FormData(document.forms.finances),
                xhr = new XMLHttpRequest();

            xhr.open("POST", "/assets/php/payment.php?action=createPayment&type=checkNewCard", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState != 4) return;
                if (xhr.status === 200) {
                    if (xhr.responseText !== "false") {
                        try {
                            let response = JSON.parse(xhr.responseText),
                                reason = "";

                            // Проверяем, есть ли ссылка на 3D-Secure
                            if (response.hasOwnProperty("confirmation")) {
                                modalFormFrame.setAttribute("src", response.confirmation["confirmation_url"]);
                            } else if (response.status !== "") {
                                if (response.status === "canceled") {
                                    reason = response.cancellation_details.reason;
                                }
                                modalFormFrame.setAttribute("src", "'~$_modx->config['site_url']~'payment-status?status=" + response.status + "&reason=" + reason);
                            }

                            document.body.classList.add("loaded");

                            // Получаем сообщение об закрытии модалки
                            window.addEventListener("message", function(event) {
                                var message = event.data;
                                if (message == "closeModal") {
                                    setTimeout(() => {
                                        closeModal();

                                        document.body.classList.remove("loaded");
                                        let newXhr = new XMLHttpRequest(),
                                            formDataPaymentInfo = new FormData();
                                            formDataPaymentInfo.append("paymentID", response.id);

                                        newXhr.open("POST", "/assets/php/payment.php?action=getPaymentInfo", true);
                                        newXhr.onreadystatechange = function() {
                                            if (newXhr.readyState != 4) return;
                                            if (newXhr.status === 200) {
                                                try {
                                                    let responsePaymentInfo = JSON.parse(newXhr.responseText);

                                                    if (responsePaymentInfo.status !== "canceled") {
                                                        let refundXhr = new XMLHttpRequest(),
                                                            formDataRefund = new FormData();
                                                            formDataRefund.append("paymentID", response.id);
                                                            formDataRefund.append("paymentValue", response.amount.value);

                                                        // Если все успешно, то создаем возврат
                                                        refundXhr.open("POST", "/assets/php/payment.php?action=createRefund", true);
                                                        refundXhr.onreadystatechange = function() {
                                                            if (refundXhr.readyState != 4) return;
                                                            if (refundXhr.status === 200) {
                                                                try {
                                                                    let responseRefundInfo = JSON.parse(refundXhr.responseText);
                                                                    document.body.classList.add("loaded");

                                                                    if (responseRefundInfo.status === "succeeded") {
                                                                        alerts({state: "success", message: "Карта успешно привязана! Сейчас страница перезагрузится"});

                                                                        setTimeout(function () {
                                                                            document.forms.finances.submit();
                                                                        }, 1500);
                                                                    } else {
                                                                        exceptionError("Ошибка при возврате! Пожалуйста обратитесь в тех.поддержку сайта!");
                                                                    }
                                                                } catch (e) {
                                                                    exceptionError("Ошибка получения данных!");
                                                                }
                                                            } else {
                                                                exceptionError("Refund Request status not 200");
                                                            }
                                                        }
                                                        refundXhr.send(formDataRefund);
                                                    } else {
                                                        reason = responsePaymentInfo.cancellation_details.reason;
                                                        exceptionError("Ошибка в процессе оплаты! Причина: " + paymentReasonError(reason));
                                                    }
                                                } catch (e) {
                                                    exceptionError("Ошибка получения данных!");
                                                }
                                            } else {
                                                exceptionError("Payment Info Request status not 200");
                                            }
                                        }
                                        newXhr.send(formDataPaymentInfo);
                                    }, 2000);
                                }
                            });
                        } catch (e) {
                            exceptionError("Ошибка получения данных!");
                        }
                    }
                } else {
                    exceptionError("Request status not 200");
                }
            }
            xhr.send(formData);
        }
    }

    function exceptionError(message) {
        document.body.classList.add("loaded");
        closeModal();
        alerts({state: "error", message: message});
    }

    function closeModal() {
        nModal.close();
    }
</script>', true)}