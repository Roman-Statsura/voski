{set $nativeModalsJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/native-modals.js'
]}
{set $nativeModalsCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/native-modals.css'
]}
{set $lightgalleryCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/lightgallery.css'
]}

{set $swiperBundleJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/swiper-bundle.min.js'
]}
{set $swiperBundleCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/swiper-bundle.min.css'
]}

{set $swiperBundleJSPreload = '<link rel="preload" as="script" href="'~$swiperBundleJS~'">'}
{set $swiperBundle = '<link href="'~$swiperBundleCSS~'" rel="stylesheet">'}
{set $swiperBundlePreload = '<link rel="preload" as="style" href="'~$swiperBundleCSS~'">'}

{set $lightgalleryPreload = '<link rel="preload" as="style" href="'~$lightgalleryCSS~'">'}
{set $nativeModalsJSPreload = '<link rel="preload" as="script" href="'~$nativeModalsJS~'">'}
{set $nativeModalsCSSPreload = '<link rel="preload" as="style" href="'~$nativeModalsCSS~'">'}

{set $lightgallery = '<link href="'~$lightgalleryCSS~'" rel="stylesheet">'}
{set $nativeModalsCSSLink = '<link href="'~$nativeModalsCSS~'" rel="stylesheet">'}

{$lightgalleryPreload | htmlToHead: true}
{$lightgallery | htmlToBottom: true}
{$nativeModalsJSPreload | htmlToHead: true}
{$nativeModalsCSSPreload | htmlToHead: true}
{$nativeModalsCSSLink | htmlToHead: true}

{$swiperBundlePreload | htmlToHead: true}
{$swiperBundleJSPreload | htmlToHead: true}
{$swiperBundle | htmlToHead: true}

{set $tarotScheduleNew = '!scheduleNew' | snippet : [
    'idTarot'  => $_modx->resource.id,
    'worktime' => $_modx->resource.worktime,
    'schedule' => $_modx->resource.schedule
]}

{set $tvFilters = 'consultIDTarot=='~$_modx->resource.id~',consultStatusSession==1'}
{set $consultationsList = '!pdoResources' | snippet : [
    'parents' => 36
    'sortby' => 'publishedon'
    'sortdir' => 'DESC'
    'includeTVs' => 'consultIDTarot, consultStatusSession'
    'includeContent' => '1'
    'tvFilters' => $tvFilters
    'return' => 'json'
    'limit' => 0
] | json_decode : true}

<div class="tarot-readers">
    <div class="tarot-readers-container container">
        {'@FILE chunks/elements/alerts.tpl' | chunk : [
            'fixed' => true
        ]}
        <div class="tarot-readers-container__content tarot-readers-content">
            <div class="tarot-readers-content__body">
                <div class="tarot-readers-content__left">
                    <div class="tarot-readers-content__photo">
                        {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                            'imageField' => $_modx->resource.photo
                            'options' => 'w=275&h=275&zc=C&q=85'
                            'class' => 'tarot-readers-photo'
                        ]}
                    </div>
                    <div class="tarot-readers-content__buttons">
                        {if $modx->user->isAuthenticated()}
                            {if $_modx->user.id != $_modx->resource.idUser}
                                {if $_modx->user.extended.usertype != 3}
                                    {if count($tarotScheduleNew) > 0}
                                        {'@FILE chunks/elements/button.tpl' | chunk : [
                                            'buttonTitle' => 'Записаться к специалисту'
                                            'dataAttr' => 'data-nmodal="tarotSignUp" data-nmodal-size="largest"'
                                        ]}
                                    {else}
                                        {'@FILE chunks/elements/button.tpl' | chunk : [
                                            'buttonTitle' => 'Записаться к специалисту'
                                            'dataAttr' => 'disabled'
                                        ]}
                                    {/if}
                                {else}
                                    {'@FILE chunks/elements/button.tpl' | chunk : [
                                        'buttonTitle' => 'Записаться к специалисту'
                                        'dataAttr' => 'disabled'
                                    ]}
                                {/if}
                            {else}
                                {'@FILE chunks/elements/button.tpl' | chunk : [
                                    'type' => 'link'
                                    'buttonTitle' => 'Редактировать анкету'
                                    'link' => 'profile/questionnaire'
                                ]}
                            {/if}
                        {else}
                            {'@FILE chunks/elements/button.tpl' | chunk : [
                                'type' => 'link'
                                'buttonTitle' => 'Войти, чтобы записаться'
                                'link' => 'login'
                            ]}
                        {/if}
                    </div>
                </div>
                <div class="tarot-readers-content__right">
                    {if $modx->user->isAuthenticated()}
                        {if $_modx->user.id == $_modx->resource.idUser}
                            {if $_modx->user.extended.usertype == 3}
                                {if $_modx->resource.zoomID == ''}
                                    <div class="alert alert--error" style="display: block;">
                                        Для полноценного начала работы с нашим сервисом, необходимо чтобы вы стали участником нашей учетной записи в Zoom!<br>
                                        <a href="/profile/questionnaire">Перейдите в свою анкету</a>, чтобы отправить заявку на добавление в Zoom.
                                    </div>
                                {/if}
                            {/if}
                        {/if}

                        {if $_modx->user.extended.usertype == 2}
                            {if $_modx->user.extended.cardname == "" || $_modx->user.extended.creditnumber == "" ||
                                $_modx->user.extended.datefinished == "" || $_modx->user.extended.cvc == ""}
                                <div class="alert alert--error" style="display: block;">
                                    Уважаемый клиент! Чтобы начать полноценно пользоваться нашим сервисом, для записи на консультацию к специалистам, 
                                    необходимо привязать вашу банковскую карту во вкладке <a href="/profile/finances">Финансы</a> в настройках вашего профиля.
                                </div>
                            {/if}
                        {/if}    
                    {/if}

                    <h1 class="tarot-readers-content__name">
                        {$_modx->resource.pagetitle}
                    </h1>

                    <div class="tarot-readers-block__info--list">
                        <div class="tarot-readers-block__item--label">
                            {'@FILE chunks/elements/rating.tpl' | chunk : [
                                'count' => 5,
                                'number' => '@FILE snippets/avgRating.php' | snippet : ['idTarot' => $_modx->resource.id]
                            ]}
                        </div>
                        <div class="tarot-readers-block__item--text font-weight--500">
                            {count($consultationsList)} 
                            {'@FILE snippets/word.php' | snippet : [
                                'number' => count($consultationsList),
                                'titles' => ["сессия", "сессий"]
                            ]}
                        </div>
                    </div>

                    {if $_modx->resource.experience != ""}
                        <div class="tarot-readers-content__item">
                            <div class="tarot-readers-content__item--label">Опыт консультрования:</div>
                            <div class="tarot-readers-content__item--text">{$_modx->resource.experience} лет</div>
                        </div>
                    {/if}

                    {if $_modx->resource.price != ""}
                        <div class="tarot-readers-content__item">
                            <div class="tarot-readers-content__item--label">Цена за сеанс:</div>
                            <div class="tarot-readers-content__item--text">{$_modx->resource.price} ₽</div>
                        </div>
                    {/if}

                    <div class="tarot-readers-content__text">
                        {$_modx->resource.content}
                    </div>

                    <div class="tarot-readers-content__item tarot-readers-certs">
                        <div class="tarot-readers-certs--label">Сертификаты:</div>
                        <div id="lightgallery" class="tarot-readers-certs--list">
                            {foreach $_modx->resource.certs | json_decode: true as $key => $cert}
                                {if $cert.active == 1}
                                    <div class="tarot-readers-certs--photo">
                                        {set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                                            'input' => $cert.photo,
                                            'options' => 'w=48&h=48&zc=C&q=85'
                                        ]}
                                        {set $thumbFromGalleryWebp = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                                            'input' => $cert.photo,
                                            'options' => 'w=48&h=48&zc=C&q=85&f=webp'
                                        ]}
                                        <a href="{$cert.photo}" class="tarot-readers-certs--photo-link">
                                            <picture>
                                                <source srcset="{$thumbFromGalleryWebp}" type="image/webp">
                                                <img class="gallery-content__image"
                                                    src="{$thumbFromPhoto}"
                                                    alt="{$cert.alt}">
                                            </picture>
                                        </a>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="tarot-readers-content__block tarot-readers-block">
            <h2 class="tarot-readers-block__title">
                Наши тарологи
            </h2>
            <div class="tarot-readers-block__list">
                {set $tarotList = '!pdoResources' | snippet : [
                    'parents' => 2
                    'resources' => -$_modx->resource.id
                    'sortby' => 'publishedon'
                    'sortdir' => 'DESC'
                    'includeTVs' => 'experience, price, photo'
                    'tvFilters' => "zoomID!=''"
                    'includeContent' => '1'
                    'return' => 'json'
                    'limit' => $limit == '' ? 3 : $limit
                ] | json_decode : true}

                {foreach $tarotList as $tarotInfo}
                    {'@FILE chunks/elements/tarot-element.tpl' | chunk : [
                        'id' => $tarotInfo.id
                        'photo' => $tarotInfo["tv.photo"]
                        'pagetitle' => $tarotInfo.pagetitle
                        'experience' => $tarotInfo['tv.experience']
                        'price' => $tarotInfo['tv.price']
                        'content' => $tarotInfo.content
                    ]}
                {/foreach}
            </div>
        </div>
    </div>
</div>

{'@FILE chunks/elements/button.tpl' | chunk : [
    'buttonTitle' => 'success'
    'dataAttr' => 'style="display: none;position:absolute;left:-9999px;" data-nmodal="signUpSuccess" data-nmodal-size="largest"'
]}
{'@FILE chunks/elements/button.tpl' | chunk : [
    'buttonTitle' => 'success'
    'dataAttr' => 'style="display: none;position:absolute;left:-9999px;" data-nmodal-new="financesSecure" data-nmodal-size="large"'
]}

<div id="tarotSignUp" class="nModal">
    <form id="consultations" action="">
        <div class="preloader">
            <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                </path>
            </svg>
        </div>
        <input type="hidden" name="idTarot" value="{$_modx->resource.id}">
        <input type="hidden" name="idUser" value="{$_modx->user.id}">
        <input type="hidden" name="subjectSum" value="{$_modx->resource.price}">
        <div class="nModal-header">
            <div>
                <div class="nModal-header__title">Выберите дату и время сессии</div>
                <div class="nModal-header__subtitle">Расписание отображается в часовом поясе Moscow</div>
            </div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body ajax-data-loader">
            <div class="schedule-block__date">
                {if count($tarotScheduleNew) > 0}
                    {foreach $tarotScheduleNew as $schDate => $tarotScheduleItem}
                        <div class="schedule-block__content">
                            <div class="schedule-block__date--title">
                                {$schDate | strtotime | rusDate}
                            </div>
                            <div class="schedule-block__date--list swiper-container swiper-schedule--{$schDate | date: 'dmY'}">
                                <div class="swiper-wrapper">
                                    {foreach $tarotScheduleItem as $schItem}
                                        {set $newDateTime = $schDate ~ $schItem}
                                        <div class="schedule-block__item swiper-slide">
                                            <input id="time-{$newDateTime | date: 'dmYHi'}" class="schedule-block__item--radio" type="radio" name="schTime" value="{$schDate} {$schItem}">
                                            <label for="time-{$newDateTime | date: 'dmYHi'}" class="schedule-block__item--label">
                                                {$schItem}
                                            </label>
                                        </div>
                                    {/foreach}
                                </div>
                                <div class="swiper-scrollbar"></div>
                            </div>
                        </div>
                    {/foreach}
                {else}
                    У специалиста, еще не указано расписание для записи. Вернитесь в другое время
                {/if}
            </div>
        </div>
        <div class="nModal-buttons nModal-buttons-align_right">
            <a href="#" class="nModal-button button button-size--normal button-theme--mint" data-nmodal-callback="callback">Записаться </a>
        </div>
    </form>
</div>

<div id="signUpSuccess" class="nModal">
    {'@FILE chunks/blocks/success.tpl' | chunk : [
        'image' => '/assets/img/blocks/img_success.png',
        'title' => 'Вы записаны!',
        'text' => ''
    ]}
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
                <div class="nModal-header__title">Подтвердите оплату консультации</div>
            </div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModalNew">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body">
            <iframe src="" width="100%" height="400" frameborder="0"></iframe>
        </div>
    </form>
</div>

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/lightgallery.min.js' 
])}
{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/native-modals.js'
])}
{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/swiper-bundle.min.js'
])}
{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/paymentReasonError.js'
])}

{$_modx->regClientScript('<script>
    document.addEventListener("DOMContentLoaded", function () {   
        nModalNew.init({
            watch: true,
            backdrop: true,
            swiper: {
                init: true,
                classEvent: ".schedule-block__date--list"
            },
            alerts: {
                init: false,
                msg: "Операция отменена"
            }
        });
        
        nModal.init({
            watch: true,
            backdrop: true,
            swiper: {
                init: true,
                classEvent: ".schedule-block__date--list"
            },
            watchOptions: {
                data: '~$_modx->resource.id~',
                type: "schedule"
            }
        });

        document.body.classList.add("loaded");

        if (location.hash && location.hash === "#signup") {
            if (signupInit = document.querySelector(`[data-nmodal="tarotSignUp"]`)) {
                signupInit.click();
            }
        }
    });

    lightGallery(document.querySelector("#lightgallery"), {
        selector: ".tarot-readers-certs--photo-link"
    });

    function testPayment(formElement) {
        if (document.querySelector(`[name="schTime"]:checked`)) {
            document.body.classList.remove("loaded");
            document.querySelector(`[data-nmodal-new="financesSecure"]`).click();

            let formData = new FormData(document.forms.consultations),
                xhr = new XMLHttpRequest(),
                newXhr = new XMLHttpRequest(),
                modalFormFrame = document.querySelector("#financesSecure-form .nModal-body iframe");
            
            xhr.open("POST", "/assets/php/payment.php?action=createPayment", false);
            xhr.send(formData);

            if (xhr.status != 200) {
                alerts({state: "error", message: "XMLHttpRequest status not 200"});
            } else {
                console.log(xhr.responseText);
            }
        } else {
            alerts({state: "error", message: "Выберите время для записи"});
        }
    }

    function updateSchedule() {
        document.body.classList.remove("loaded");

        let scheduleXHR = new XMLHttpRequest(),
            formDataScheduleInfo = new FormData();

        scheduleXHR.open("POST", "/select-time", true);
        formDataScheduleInfo.append("idTarot", '~$_modx->resource.id~');

        scheduleXHR.onreadystatechange = function() {
            if (scheduleXHR.readyState != 4) return;
            if (scheduleXHR.status === 200) {
                document.querySelectorAll(".ajax-data-loader").forEach(function(element, key) {
                    if (key == 1) {
                        setTimeout(() => {
                            element.innerHTML = scheduleXHR.responseText;
                            document.body.classList.add("loaded");
                        }, 1000);
                    }
                });
            }
        }

        scheduleXHR.send(formDataScheduleInfo);
    }

    function callback(formElement) {
        // Проверяем, что время выбрано время
        if (document.querySelector(`[name="schTime"]:checked`)) {
            document.body.classList.remove("loaded");
            document.querySelector(`[data-nmodal-new="financesSecure"]`).click();

            let formData = new FormData(document.forms.consultations),
                xhr = new XMLHttpRequest(),
                newXhr = new XMLHttpRequest(),
                modalFormFrame = document.querySelector("#financesSecure-form .nModal-body iframe");
            
            xhr.open("POST", "/assets/php/payment.php?action=createPayment", true);
            xhr.onreadystatechange = function() {
                if (xhr.readyState != 4) return;
                if (xhr.status === 200) {
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
                                    closeModalNew();

                                    document.body.classList.remove("loaded");

                                    let paymentStatusXhr = new XMLHttpRequest();
                                    paymentStatusXhr.open("POST", "/assets/php/payment.php?action=getPaymentInfo", true);

                                    let formDataPaymentInfo = new FormData();
                                    formDataPaymentInfo.append("paymentID", response.id);

                                    paymentStatusXhr.onreadystatechange = function() {
                                        if (paymentStatusXhr.readyState != 4) return;
                                        if (paymentStatusXhr.status === 200) {
                                            try {
                                                let responsePaymentInfo = JSON.parse(paymentStatusXhr.responseText);

                                                if (responsePaymentInfo.status !== "canceled") {
                                                    let xhrMew = new XMLHttpRequest(),
                                                        signUpModal = document.querySelector("#tarotSignUp"),
                                                        signUpSuccess = document.querySelector("#signUpSuccess"),
                                                        signUpSuccessText = document.querySelector("#signUpSuccess .success-info__text");

                                                    formData.append("paymentID", response.id);

                                                    // Если все успешно, то создаем консультацию
                                                    xhrMew.open("POST", "/assets/php/addConsultation.php", true);
                                                    xhrMew.onreadystatechange = function() {
                                                        if (xhrMew.readyState != 4) return;
                                                        try {
                                                            let result = JSON.parse(xhrMew.responseText);
                                                            signUpSuccessText.innerHTML = result.message;

                                                            nModal.closeWithoutAnim();
                                                            document.body.classList.add("loaded");
                                                            document.querySelector(`[data-nmodal="signUpSuccess"]`).click();

                                                            setTimeout(() => {
                                                                nModal.close();
                                                            }, 4000);
                                                        } catch (e) {
                                                            exceptionError("Ошибка получения данных!", "new");
                                                        }
                                                    }
                                                    xhrMew.send(formData);
                                                }
                                            } catch (e) {
                                                exceptionError("Ошибка получения данных!", "new");
                                            }
                                        } else {
                                            exceptionError("Payment Info Request status not 200");
                                        }
                                    }
                                    paymentStatusXhr.send(formDataPaymentInfo);
                                }, 2000);
                            }
                        });
                    } catch (e) {
                        exceptionError("Ошибка получения данных!", "new");
                    }
                } else {
                    exceptionError("Request status not 200");
                }
            }
            xhr.send(formData);
        } else {
            alerts({state: "error", message: "Выберите время для записи"});
        }
    }

    function exceptionError(message, modal = "old") {
        document.body.classList.add("loaded");
        if (modal === "new") {
            closeModalNew()
        } else {
            closeModal();
        }
        alerts({state: "error", message: message});
    }

    function closeModal() {
        nModal.close();
    }

    function closeModalNew() {
        nModalNew.close();
        document.body.classList.add("loaded");
    }
</script>',true)}