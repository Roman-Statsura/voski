{set $nativeModalsJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/native-modals.js'
]}
{set $nativeModalsCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/native-modals.css'
]}

{set $nativeModalsJSPreload = '<link rel="preload" as="script" href="'~$nativeModalsJS~'">'}
{set $nativeModalsCSSPreload = '<link rel="preload" as="style" href="'~$nativeModalsCSS~'">'}
{set $nativeModalsCSSLink = '<link href="'~$nativeModalsCSS~'" rel="stylesheet">'}

{$nativeModalsJSPreload | htmlToHead: true}
{$nativeModalsCSSPreload | htmlToHead: true}
{$nativeModalsCSSLink | htmlToHead: true}

{'!UpdateProfile' | snippet : [
    'validate' => ''
    'placeholderPrefix' => 'upd.'
    'submitVar' => 'login-updprof-btn'
]}

<div class="login">
    <div class="login-container login-container--100 container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                {'@FILE chunks/elements/alerts.tpl' | chunk : [
                    'fixed' => true
                ]}
                <h2 class="login-content__header--title">Мои консультации</h2>
                <div class="login-content__header--subtitle">
                    Здесь отображаются ваши консультации актуальные или прошедшие
                </div>
            </div>
            <div class="login-content__body">
                <div class="login-tpl-form__group">
                    <div class="login-tpl-form__group--item">
                        <input id="current" class="form__radio login-tpl-form__item--input" type="radio" name="consultationType" value="1" checked />
                        <label for="current" class="form__label login-tpl-form__item--label">
                            Текущие
                        </label>
                    </div>
                    <div class="login-tpl-form__group--item">
                        <input id="closed" class="form__radio login-tpl-form__item--input" type="radio" name="consultationType" value="2" />
                        <label for="closed" class="form__label login-tpl-form__item--label">
                            Закрытые 
                        </label>
                    </div>
                </div>

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
                                    consultDesc, consultStatusSession, consultDuration, consultSended',
                    'includeContent' => '1',
                    'return' => 'json',
                    'limit' => 0
                ] | json_decode : true}

                <div class="table-flex table-consultation">
                    <div class="table-flex--row table-flex--head">
                        <div class="table-flex--col">Дата</div>
                        <div class="table-flex--col">{if $_modx->user.extended.usertype == 3}Клиент{else}Таролог{/if}</div>
                        <div class="table-flex--col">Описание</div>
                        <div class="table-flex--col">Статус сеанса</div>
                        <div class="table-flex--col">Продолжительность</div>
                    </div>

                    {set $innerCount = 0}
                    {set $innerCountClosed = 0}

                    {if count($consultations) > 0}
                        {foreach $consultations as $key => $consultItem}
                            {if ($_modx->user.extended.usertype == 3 && $consultItem['tv.consultIDTarot'] == $userQuestResourse) || ($_modx->user.extended.usertype == 2 && $consultItem['tv.consultIDClient'] == $_modx->getPlaceholder('upd.internalKey'))}
                                <div class="login-finances__tab login-tab tab" data-id="1">
                                    {if $consultItem.published}
                                        {if $consultItem['tv.consultStatusSession'] != 1 && $consultItem['tv.consultStatusSession'] != 2 && $consultItem['tv.consultStatusSession'] != 3}
                                            {if $_modx->user.extended.usertype == 3}
                                                {set $userFullname = '@FILE snippets/getUserNameByID.php' | snippet : [
                                                    'id' => $consultItem['tv.consultIDClient']
                                                    'field' => 'fullname'
                                                ]}
                                            {else}
                                                {set $userFullname = $consultItem['tv.consultIDTarot'] | resource : 'pagetitle'}
                                            {/if}

                                            {set $innerCount = $innerCount + 1}

                                            <div class="table-flex--row table-flex--body nModal-button" data-cnsid="{$key}" data-consultation="cnsid-{$consultItem.id}" data-name="{$userFullname}" data-usergroup="{$_modx->user.extended.usertype}" data-nmodal-callback="clickTest" data-nmodal="consultDetailed" data-nmodal-size="large">
                                                <div class="table-flex--item">
                                                    <div class="table-flex--col">{$consultItem['tv.consultDatetime'] | date: 'd.m.Y H:i'}</div>
                                                    <div class="table-flex--col">{$userFullname}</div>
                                                    <div class="table-flex--col consult-text">
                                                        {$consultItem.content | strip_tags}
                                                    </div>
                                                    <div class="table-flex--col">
                                                        <span data-info="statusSession" class="table-consultation__status {if $consultItem['tv.consultStatusSession'] == 1}table-consultation__status--green{/if}{if $consultItem['tv.consultStatusSession'] == 2}table-consultation__status--red{/if}">
                                                            {'@FILE snippets/getStatusSessionName.php' | snippet : [
                                                                'sessionID' => $consultItem['tv.consultStatusSession']
                                                            ]}
                                                        </span>
                                                    </div>
                                                    <div data-info="duration" class="table-flex--col table-consultation__duration">
                                                        {set $timeDuration = '@FILE snippets/secToTime.php' | snippet : [
                                                            'seconds' => $consultItem['tv.consultDuration']
                                                        ]}
                                                        {$timeDuration}
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    {/if}
                                </div>
                                <div class="login-finances__tab login-tab tab" data-id="2">
                                    {if $consultItem.published}
                                        {if $consultItem['tv.consultStatusSession'] == 1 || $consultItem['tv.consultStatusSession'] == 2 || $consultItem['tv.consultStatusSession'] == 3}
                                            {if $_modx->user.extended.usertype == 3}
                                                {set $userFullname = '@FILE snippets/getUserNameByID.php' | snippet : [
                                                    'id' => $consultItem['tv.consultIDClient']
                                                    'field' => 'fullname'
                                                ]}
                                            {else}
                                                {set $userFullname = $consultItem['tv.consultIDTarot'] | resource : 'pagetitle'}
                                            {/if}

                                            {set $innerCountClosed = $innerCountClosed + 1}

                                            <div class="table-flex--row table-flex--body" data-cnsid="{$key}" data-consultation="cnsid-{$consultItem.id}" data-name="{$userFullname}" data-usergroup="{$_modx->user.extended.usertype}" data-nmodal-callback="clickTest" data-nmodal="consultDetailed" data-nmodal-size="large">
                                                <div class="table-flex--item">
                                                    <div class="table-flex--col">{$consultItem['tv.consultDatetime'] | date: 'd.m.Y H:i'}</div>
                                                    <div class="table-flex--col">{$userFullname}</div>
                                                    <div class="table-flex--col consult-text">
                                                        {$consultItem.content | strip_tags}
                                                    </div>
                                                    <div class="table-flex--col">
                                                        <span data-info="statusSession" class="table-consultation__status {if $consultItem['tv.consultStatusSession'] == 1}table-consultation__status--green{/if}{if $consultItem['tv.consultStatusSession'] == 2}table-consultation__status--red{/if}">
                                                            {'@FILE snippets/getStatusSessionName.php' | snippet : [
                                                                'sessionID' => $consultItem['tv.consultStatusSession']
                                                            ]}
                                                        </span>
                                                    </div>
                                                    <div data-info="duration" class="table-flex--col table-consultation__duration">
                                                        {set $timeDuration = '@FILE snippets/secToTime.php' | snippet : [
                                                            'seconds' => $consultItem['tv.consultDuration']
                                                        ]}
                                                        {$timeDuration}
                                                    </div>
                                                </div>
                                            </div>
                                        {/if}
                                    {/if}
                                </div>
                            {/if}
                        {/foreach}
                        <div class="login-finances__tab login-tab tab" data-id="1">
                            {if $innerCount == 0}
                                <div class="table-flex--row table-flex--body">
                                    <div class="table-flex--col table-flex--col--full">На данный момент, консультации нет</div>
                                </div>
                            {/if}
                        </div>
                        <div class="login-finances__tab login-tab tab" data-id="2">
                            {if $innerCountClosed == 0}
                                <div class="table-flex--row table-flex--body">
                                    <div class="table-flex--col table-flex--col--full">На данный момент, консультации нет</div>
                                </div>
                            {/if}
                        </div>
                    {else}
                        <div class="table-flex--row table-flex--body">
                            <div class="table-flex--col table-flex--col--full">На данный момент, консультации нет</div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div> 

{'@FILE chunks/elements/button.tpl' | chunk : [
    'buttonTitle' => 'success'
    'dataAttr' => 'style="display: none;position:absolute;left:-9999px;" data-nmodal-new="confirmation" data-nmodal-size="large"'
]}

<div id="consultDetailed" class="nModal">
    <form id="consultInfo" action="">
    </form>
</div>

<div id="confirmation" class="nModal">
    <form id="confirmation-form" action="">
        <input type="hidden" name="idConsult" value="">

        <div class="preloader">
            <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                </path>
            </svg>
        </div>
        <div class="nModal-header">
            <div>
                <div class="nModal-header__title">Подтвердите отмену консультации</div>
            </div>
        </div>
        <div class="nModal-body">
            <p>Вы уверены, что хотите отменить консультацию? Данное действие необратимо.</p>
        </div>
        <div class="nModal-buttons nModal-buttons-align_right">
            <a href="#" class="nModal-button button button-size--normal button-theme--red" data-nmodal-callback="confirmCancel">Да</a>
            <a href="#" class="nModal-button button button-size--normal button-theme--mint" data-nmodal-callback="closeModalNew">Нет</a>
        </div>
    </form>
</div>

{$_modx->regClientScript($nativeModalsJS)}

{$_modx->regClientScript('<script>
    let financesCheckboxes = document.querySelectorAll(`.form__radio[name="consultationType"]`),
        financestypeChecked = document.querySelector(`.form__radio[name="consultationType"]:checked`),
        financesTabs = document.querySelectorAll(".login-finances__tab"),
        nModalInitedRow = document.querySelector(`[data-nmodal="consultDetailed"]`),
        ajaxContainerSelector = `.ajax-container`,
        currentUser = `'~$userQuestResourse~'`,
        curUserGroup = `'~$_modx->user.extended.usertype~'`,
        intervalId = 0;

    var socket = new WebSocket("ws://localhost:8080");

    socket.onopen = function() {};

    socket.onmessage = function(e) {
        if (e.data !== "nothingSave") {
            let newConsult = JSON.parse(e.data);
            
            newConsult.forEach(element => {
                if (element["tv.consultIDTarot"] === currentUser || element["tv.consultIDClient"] === currentUser) {
                    let idCon = element["id"];
                    let listConsultStatus = document.querySelector(`[data-consultation="cnsid-${idCon}"] [data-info="statusSession"]`),
                        listConsultDuration = document.querySelector(`[data-consultation="cnsid-${idCon}"] [data-info="duration"]`);

                    if (Number(element["tv.consultStatusSession"]) === 0) {
                        listConsultStatus.innerHTML = "В ожидании";
                        if (listConsultStatus.classList.contains("table-consultation__status--green")) {
                            listConsultStatus.classList.remove("table-consultation__status--green");
                        }
                        listConsultDuration.innerHTML = secToTime(Number(element["tv.consultDuration"]));

                        if (intervalId > 0) {
                            clearInterval(intervalId);
                            intervalId = 0;
                        }
                    }
                    if (Number(element["tv.consultStatusSession"]) === 1) {
                        listConsultStatus.innerHTML = "Проведен";
                        listConsultStatus.classList.add("table-consultation__status--green");
                        listConsultDuration.innerHTML = secToTime(Number(element["tv.consultDuration"]));

                        if (intervalId > 0) {
                            clearInterval(intervalId);
                            intervalId = 0;
                        }
                    }
                    if (Number(element["tv.consultStatusSession"]) === 4) {
                        listConsultStatus.innerHTML = "Проводится";
                        if (listConsultStatus.classList.contains("table-consultation__status--green")) {
                            listConsultStatus.classList.remove("table-consultation__status--green");
                        }
                        listConsultDuration.innerHTML = secToTime(Number(element["tv.consultDuration"]));
                    }

                    alerts({state: "success", message: "Консультации обновлены"});
                }
            });
        }
    };

    socket.onclose = function(event) {
        if (event.wasClean) {
        } else {
            alerts({state: "error", message: "Обрыв соединения"});
        }
    };

    socket.onerror = function(error) {
        //console.log(error);
    };

    document.addEventListener("DOMContentLoaded", function () {     
        nModalNew.init({
            watch: true,
            backdrop: true
        });
        
        nModal.init({
            watch: true,
            backdrop: true
        });

        document.body.classList.add("loaded");

        var xhrConsult = new XMLHttpRequest();
        xhrConsult.open("GET", "/assets/php/getConsultationList.php", false);
        xhrConsult.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhrConsult.send();

        let newConsult = JSON.parse(xhrConsult.responseText);

        if (xhrConsult.status != 200) {
            alerts({state: "error", message: "XMLHttpRequest status not 200"});
        } else {
            newConsult.forEach(element => {                
                if (Number(element["tv.consultStatusSession"]) === 4) {
                    let listConsultDuration = document.querySelector(`[data-consultation="cnsid-${element.id}"] [data-info="duration"]`);
                    intervalId = setInterval(function() {
                        seconds = updateTimer(element.id, element["tv.consultZoomID"]);
                        listConsultDuration.innerHTML = secToTime(seconds);

                        if (socket.readyState === 1) {
                            socket.send(`{"resID": ${element.id}}`);
                        }
                    }, 60000);
                }
            });
        }
    });

    function clickTest(event) {
        var xhrConsult = new XMLHttpRequest();

        xhrConsult.open("GET", "/assets/php/getConsultationList.php", false);
        xhrConsult.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhrConsult.send();

        if (xhrConsult.status != 200) {
            alerts({state: "error", message: "XMLHttpRequest status not 200"});
        } else {
            let cnsID = event.dataset.cnsid,
                cnsArray = event.dataset.cnsid, 
                newConsult = JSON.parse(xhrConsult.responseText),
                fullname = event.dataset.name,
                usergroup = event.dataset.usergroup,
                duration = event.dataset.duration,
                intervalId = 0,
                dateTime = new Date(newConsult[cnsArray]["tv.consultDatetime"]).getTime() / 1000,
                today = parseInt(new Date().getTime() / 1000),
                expiredConsult = false;

            if (dateTime <= today) {
                expiredConsult = true;
            }

            if (Number(newConsult[cnsArray]["tv.consultStatusSession"]) === 0) {
                callbackFunc = "startMeeting";
                if (usergroup == 2) {
                    callbackTitle = "Перейти к консультации";
                } else {
                    callbackTitle = "Начать консультацию";
                }
                buttonTheme = "button-theme--mint";
            } else if (Number(newConsult[cnsArray]["tv.consultStatusSession"]) === 4) {
                callbackFunc = "stopMeeting";
                buttonTheme = "button-theme--red";

                if (usergroup == 2) {
                    callbackTitle = "Перейти к консультации";
                } else {
                    callbackTitle = "Закончить консультацию";
                }
            } else {
                callbackFunc = "stopMeeting";
                buttonTheme = "button-theme--red";

                if (usergroup == 2) {
                    callbackTitle = "Перейти к консультации";
                } else {
                    callbackTitle = "Закончить консультацию";
                }
            }

            if (Number(newConsult[cnsArray]["tv.consultStatusSession"]) !== 1 && 
                Number(newConsult[cnsArray]["tv.consultStatusSession"]) !== 2 && 
                Number(newConsult[cnsArray]["tv.consultStatusSession"]) !== 3) 
            {
                if (usergroup == 2) {
                    if (dateTime <= today || Number(newConsult[cnsArray]["tv.consultStatusSession"]) !== 0) {
                        buttonLink = `
                            <a href="${newConsult[cnsArray]["tv.consultZoomLink"]}" target="_blank" class="nModal-button button button-size--normal button-theme--mint">${callbackTitle}</a>
                        `;
                    } else {
                        buttonLink = `
                            <a href="${newConsult[cnsArray]["tv.consultZoomLink"]}" target="_blank" class="nModal-button button button-size--normal button-theme--mint">${callbackTitle}</a>
                            <a href="#" class="button button-size--normal button-theme--red nModal-button" data-idcns="${newConsult[cnsArray]["id"]}" data-nmodal-callback="cancelConsult">Отменить консультацию</a>
                        `;
                    }
                } else {
                    buttonLink = `<a href="${newConsult[cnsArray]["tv.consultZoomStartLink"]}" target="_blank" class="button button-size--normal ${buttonTheme} nModal-button" 
                                    data-action="meeting"
                                    data-cnsid="${cnsArray}"
                                    data-migxid="${newConsult[cnsArray]["id"]}"
                                    data-zoomid="${newConsult[cnsArray]["tv.consultZoomID"]}"
                                    data-nmodal-callback="${callbackFunc}">
                                    ${callbackTitle}
                                </a>`;
                }
            } else {
                buttonLink = "";
            }

            let modalDiv = `
                <div class="preloader">
                    <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor"
                            d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                        </path>
                    </svg>
                </div>
                <div class="nModal-header">
                    <div>
                        <div class="nModal-header__title">Консультация №${newConsult[cnsArray]["id"]} от ${newConsult[cnsArray]["tv.consultDatetime"]}</div>
                    </div>
                    <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M26 14L14 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                            <path d="M14 14L26 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
                        </svg>
                    </a>
                </div>
                <div class="nModal-body">
                    <div class="nModal-body__list">
                        <div class="nModal-body__item">
                            <div class="nModal-body__record">Дата:</div>
                            <div class="nModal-body__record">${newConsult[cnsArray]["tv.consultDatetime"]}</div>
                        </div>
                        <div class="nModal-body__item">
                            <div class="nModal-body__record">${usergroup == 2 ? "Таролог:" : "Клиент:"}</div>
                            <div class="nModal-body__record">${fullname}</div>
                        </div>
                        <div class="nModal-body__item flex-direction--column">
                            <div class="nModal-body__record">Описание:</div>
                            <div class="nModal-body__record">${newConsult[cnsArray]["content"]}</div>
                        </div>
                    </div>
                </div>
                <div class="nModal-buttons nModal-buttons-align_right">
                    ${buttonLink}
                </div>
            `;
            document.querySelector("#consultInfo").innerHTML = modalDiv;
        }
    }

    function closeModal() {
        nModal.close();
    }

    function cancelConsult(formElement, event) {
        document.querySelector(`[data-nmodal-new="confirmation"]`).click();
        
        let idConsultField = document.querySelector(`#confirmation-form [name="idConsult"]`);
        idConsultField.value = event.dataset.idcns
    }

    function confirmCancel(formElement) {
        document.body.classList.remove("loaded");
        let idConsultField = document.querySelector(`#confirmation-form [name="idConsult"]`);

        var xhr = new XMLHttpRequest(),
            params = "idConsult=" + idConsultField.value;

        xhr.open("POST", "/assets/php/cancelConsultation.php", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function() {
            if (xhr.readyState != 4) return;
            if (xhr.status === 200) {
                try {
                    let result = JSON.parse(xhr.responseText);
                    alerts(result);

                    document.body.classList.add("loaded");
                    nModalNew.close();
                    nModal.close();
                    socket.send(``);
                } catch (e) {
                    exceptionError("Ошибка получения данных!");
                }
            } else {
                exceptionError("Request status not 200");
            }
        }
        xhr.send(params);
    }

    function secToTime(sec) {
        var sec_num = sec;
        var hours   = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);

        if (hours < 10) {
            hours = "0" + hours;
        }
        if (minutes < 10) {
            minutes = "0" + minutes;
        }
        if (seconds < 10) {
            seconds = "0" + seconds;
        }
        return hours + " ч " + minutes + " мин";
    }

    function updateTimer(migxid, zoomID) {
        var xhr = new XMLHttpRequest();
        var params = "id=" + migxid + 
                     "&meetingId=" + zoomID;

        xhr.open("POST", "/assets/php/updateTimeSession.php", false);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.send(params);

        if (xhr.status != 200) {
            alerts({state: "error", message: "XMLHttpRequest status not 200"});
        } else {
            return xhr.responseText;
        }
    }

    function startMeeting(form, event) {
        document.body.classList.remove("loaded");
        var xhr = new XMLHttpRequest();
        let zoomID = event.dataset.zoomid,
            duration = event.dataset.duration,
            migxid = event.dataset.migxid,
            callback = event.dataset.nmodalCallback,
            cnsID = event.dataset.cnsid;
            listConsultStatus = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="statusSession"]`),
            listConsultDuration = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="duration"]`),
            intervalId = 0;

        xhr.open("GET", "/assets/php/zoomGetMeeting.php?id=" + migxid + "&meetingId=" + zoomID, true);
        xhr.onreadystatechange = function() {
            if (this.readyState != 4) return;
            let result = JSON.parse(this.responseText);
            alerts(result);

            if (result.state === "success") {
                event.innerHTML = "Закончить консультацию";
                event.classList.remove("button-theme--mint");
                event.classList.add("button-theme--red");
                event.dataset.nmodalCallback = "stopMeeting";
                listConsultStatus.innerHTML = "Проводится";

                intervalId = setInterval(function() {
                    seconds = updateTimer(migxid, zoomID);
                    listConsultDuration.innerHTML = secToTime(seconds);

                    if (socket.readyState === 1) {
                        socket.send(`{"resID": ${migxid}}`);
                    }
                }, 60000);

                if (socket.readyState === 1) {
                    socket.send(`{"resID": ${migxid}}`);
                }

                window.open(event.href, "_blank");
                document.body.classList.add("loaded");
                nModal.close();
            }
        }
        xhr.send();
    }

    function stopMeeting(form, event) {
        document.body.classList.remove("loaded");
        let zoomID = event.dataset.zoomid,
            duration = event.dataset.duration,
            migxid = event.dataset.migxid,
            callback = event.dataset.nmodalCallback,
            listConsultStatus = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="statusSession"]`),
            listConsultDuration = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="duration"]`);

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "/assets/php/zoomGetMeeting.php?id=" + migxid + "&meetingId=" + zoomID + "&action=end", true);
        xhr.onreadystatechange = function() {
            let result = JSON.parse(this.responseText);
            alerts(result);

            if (result.state === "success") {
                clearInterval(intervalId);
                intervalId = 0;

                seconds = updateTimer(migxid, zoomID);
                listConsultDuration.innerHTML = secToTime(seconds);

                if (socket.readyState === 1) {
                    socket.send(`{"resID": ${migxid}}`);
                }

                event.remove();
                listConsultStatus.innerHTML = "Проведен";
                document.body.classList.add("loaded");
                nModal.close();
            }
        }
        
        xhr.send();
    }

    function debugMeeting(form, event) {
        let zoomID = event.dataset.zoomid,
            duration = event.dataset.duration,
            migxid = event.dataset.migxid,
            callback = event.dataset.nmodalCallback,
            listConsultStatus = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="statusSession"]`),
            listConsultDuration = document.querySelector(`[data-consultation="cnsid-${migxid}"] [data-info="duration"]`);

        var xhr = new XMLHttpRequest();
        xhr.open("GET", "/assets/php/zoomGetMeeting.php?id=" + migxid + "&meetingId=" + zoomID + "&action=debug", true);
        xhr.onreadystatechange = function() {
            console.log(this.responseText);
        }
        xhr.send();
    }

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

    function exceptionError(message) {
        document.body.classList.add("loaded");
        closeModal();
        alerts({state: "error", message: message});
    }

    function closeModalNew() {
        nModalNew.close();
    }
</script>', true)}