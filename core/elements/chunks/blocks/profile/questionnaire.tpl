{set $selectPureJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/select-pure-bundle.min.js'
]}
{set $selectPureCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/select-pure.css'
]}

{set $selectPureJSPreload = '<link rel="preload" as="script" href="'~$selectPureJS~'">'}
{set $selectPureCSSPreload = '<link rel="preload" as="style" href="'~$selectPureCSS~'">'}
{set $fontAwesomeCSSPreload = '<link rel="preload" as="style" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">'}
{set $selectPureCSSLink = '<link href="'~$selectPureCSS~'" rel="stylesheet">'}
{set $fontAwesomeCSSLink = '<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">'}

{$selectPureJSPreload | htmlToHead: true}
{$selectPureCSSPreload | htmlToHead: true}
{$selectPureCSSLink | htmlToHead: true}
{$fontAwesomeCSSLink | htmlToHead: true}

{'!UpdateProfile' | snippet : [
    'validate' => ''
    'placeholderPrefix' => 'upd.'
    'submitVar' => 'login-updprof-btn'
]}

{set $userQuestResourse = '@FILE snippets/findUserAndReview.php' | snippet : [
    'id' => $_modx->getPlaceholder('upd.id')
]}

{if $userQuestResourse}
    {set $isModerate = $userQuestResourse | resource : 'isModerate'}
    {set $content = $userQuestResourse | resource : 'content-pre' | strip_tags}
    {set $photo = $userQuestResourse | resource : 'photo-pre'}
    {set $city = $userQuestResourse | resource : 'city-pre'}
    {set $experience = $userQuestResourse | resource : 'experience-pre'}
    {set $specialization = $userQuestResourse | resource : 'specialization-pre'}
    {set $price = $userQuestResourse | resource : 'price-pre'}
    {set $certs = $userQuestResourse | resource : 'certs-pre'}
    {set $statusInviteZoom = $userQuestResourse | resource : 'statusInviteZoom'}
{else}
    {set $certs = ""}
{/if}

{set $zoomUserID = '@FILE snippets/getZoomUserID.php' | snippet : [
    'currentEmail' => $_modx->getPlaceholder('upd.email')
    'currentUser'  => $userQuestResourse
]}

<div class="login">
    <div class="login-container login-container--wide container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                <h2 class="login-content__header--title">Анкета</h2>
                {if $isModerate}
                    <div class="alert alert--info" style="display: block;">
                        Ваша анкета на модерации
                    </div>
                {/if}
                {if !$zoomUserID}
                    <div class="alert alert--error" data-alert="invite" style="display: block;">
                        Для полноценного начала работы с нашим сервисом, необходимо чтобы вы стали участником нашей учетной записи в Zoom!<br>
                        <a href="#" data-action="sendInvite">Нажмите сюда</a>, чтобы отправить заявку на добавление в Zoom.
                    </div>
                {/if}
                {if $zoomUserID == "pending"}
                    <div class="alert alert--info" style="display: block;">
                        Приглашение успешно отправлено! Проверьте вашу электронную почту и пройдите предложенные этапы для завершения.
                    </div>
                {/if}
                {if $zoomUserID == "sendRequest"}
                    <div class="alert alert--info" style="display: block;">
                        Ваша заявка успешно отправлена! После того, как ваша заявка обработается, вы получите на вашу электронную почту приглашение добавление в учетную запись Zoom.
                    </div>
                {/if}
                
                <div data-action="alert" class="alert alert--fixed">
                    Анкета отправлена на модерацию
                </div>
                <div class="login-content__header--subtitle">
                    Пожалуйста заполните анкету и отправьте нам на модерацию.<br>
                    Как только анкета пройдет модерацию вы сможете приступить к работе.
                </div>
            </div>
            <div class="login-content__body">
                {$errors}

                {set $specList = 1 | resource : 'specList'}

                <div class="login-tpl register">
                    <div class="login-tpl-message">{$_modx->getPlaceholder('upd.error.message')}</div>
                    <div class="login-tpl-content">
                        <form id="questionnaire" name="questionnaire" class="form login-tpl-content__form login-form" action="" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="nospam:blank" value="" />
                            <input type="hidden" name="idUser" value="{$_modx->getPlaceholder('upd.id')}" />
                            <input type="hidden" name="fullname" value="{$_modx->getPlaceholder('upd.fullname')}" />

                            <div class="login-tpl-form__list">
                                {if $zoomUserID && $zoomUserID != "sendRequest" && $zoomUserID != "pending"}
                                    <div class="login-tpl-form__item">
                                        <div class="login-tpl-form__item--left">
                                            <label class="form__label login-tpl-form__item--label" for="zoomid">
                                                Zoom ID
                                                <span class="error">{$_modx->getPlaceholder('upd.error.fullname')}</span>
                                            </label>
                                        </div>
                                        <div class="login-tpl-form__item--right">
                                            <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="zoomid" id="zoomid" value="{$zoomUserID}" placeholder="Ссылка на Zoom" disabled />
                                            <small class="form__error">Заполните поле</small>
                                        </div>
                                    </div>
                                {/if}
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="photo">
                                            Ваше фото
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <label class="form__label login-tpl-form__item--label-photo photo-preload {$photo != '' ? 'preload' : ''}" for="photo" {$photo != '' ? 'style="background-image: url(' ~ $photo ~ ');"' : ''}>
                                            <input class="form__input form__input--file" name="photo" id="photo" type="file" value="{$photo}">
                                            <div id="imgPhoto" class="form__label--photos"></div>
                                        </label>
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="city">
                                            Ваш город
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="city" id="city" value="{$city}" placeholder="Ваш город" />
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="experience">
                                            Опыт работы
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="experience" id="experience" value="{$experience}" placeholder="Опыт работы" />
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="specialization">
                                            Специализация
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="hidden" name="specialization" id="specialization">
                                        <span class="multi-select"></span>
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="price">
                                            Цена за сеанс
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right">
                                        <input type="text" class="form__input form__input--tel login-tpl-form__item--input" name="price" id="price" value="{$price}" placeholder="Цена за сеанс" />
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left">
                                        <label class="form__label login-tpl-form__item--label" for="certs">
                                            Ваши сертификаты
                                        </label>
                                    </div>
                                    <div class="login-tpl-form__item--right flex-direction--row">
                                        <label class="form__label login-tpl-form__item--label-photo" for="certs">
                                            <input class="form__input form__input--file" multiple name="certs[]" id="certs" type="file">
                                        </label>
                                        <input class="form__input form__input--file" name="uploaded-certs" id="uploaded-certs" type="hidden" value="">
                                        <div id="images" class="form__label--photos">
                                            {foreach $certs | json_decode: true as $key => $cert}
                                                <div class="form__label--photo">
                                                    <img src="{$cert.photo}" alt="" />
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item justify-content--center">
                                    <div class="login-tpl-form__item--full">
                                        <label class="form__label login-tpl-form__item--label" for="about">
                                            Расскажите о себе. Напишите небольшой текст, не менее 20 строк.
                                        </label>
                                        <textarea class="form__input form__input--textarea login-tpl-form__item--input" name="about" id="about" rows="6" placeholder="Расскажите о себе...">{$content}</textarea>
                                    </div>
                                </div>
                
                                <div class="login-tpl-form__item">
                                    <div class="login-tpl-form__item--left"></div>
                                    <div class="login-tpl-form__item--right display__block">
                                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="send-profile" id="send-profile" value="Отправить на модерацию" />
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

{$_modx->regClientScript($selectPureJS)}

{$_modx->regClientScript('<script>
    let photoBlock = document.querySelector("#photo"),
        mainLabelPhoto = document.querySelector(".photo-preload img"),
        labelPhoto = document.querySelector(".login-tpl-form__item--label-photo"),
        sendProfileButton = document.querySelector(`[name="send-profile"]`),
        alertDOM = document.querySelector(`[data-action="alert"]`),
        specializationDOM = document.querySelector("#specialization"),
        photosBlock = document.querySelector(`#certs`),
        uploadedCerts = `'~ $certs ~'`,
        specList = '~ $specList ~',
        currentSpec = "'~$specialization~'",
        currentSpecArray = currentSpec.split(","),
        selectOptions = [];

    specList.forEach(element => {
        let selectInput = {};
        selectInput["label"] = element.title;
        selectInput["value"] = element.alias;

        selectOptions.push(selectInput);
    });

    specializationDOM.value = currentSpecArray;

    var multi = new SelectPure(".multi-select", {
        options: selectOptions,
        multiple: true,
        icon: "fa fa-times",
        placeholder: "Выберите",
        onChange: value => { 
            specializationDOM.value = value;
        },
        value: currentSpecArray == "" ? "" : currentSpecArray,
        classNames: {
            select: "select-pure__select",
            dropdownShown: "select-pure__select--opened",
            multiselect: "select-pure__select--multiple",
            label: "select-pure__label",
            placeholder: "select-pure__placeholder",
            dropdown: "select-pure__options",
            option: "select-pure__option",
            autocompleteInput: "select-pure__autocomplete",
            selectedLabel: "select-pure__selected-label",
            selectedOption: "select-pure__option--selected",
            placeholderHidden: "select-pure__placeholder--hidden",
            optionHidden: "select-pure__option--hidden",
        }
    });
    var resetMulti = function() {
        multi.reset();
    };

    function checkImagesBeforeUpload(input) {
        var files = input.files || input.currentTarget.files;
        var reader = [];
        var images = document.getElementById("imgPhoto");
        var name;
        for (var i in files) {
            if (files.hasOwnProperty(i)) {
                name = "file" + i;
                reader[i] = new FileReader();
                reader[i].readAsDataURL(input.files[i]);
                images.innerHTML = "";

                images.innerHTML += `<div class="form__label--photo">
                    <img id="${name}" src="" alt="" />
                </div>`;
                
                (function (name) {
                    reader[i].onload = function (e) {
                        document.querySelector(".photo-preload img").src = e.target.result;
                        document.querySelector(".photo-preload img").classList.add("preload");
                    };
                })(name);
            }
        }
    }

    checkImagesBeforeUpload(photoBlock);

    photoBlock.addEventListener("change", function() {
        checkImagesBeforeUpload(this);
    });

    document.querySelector(`#certs`).addEventListener("change", function() {
        let files = photosBlock.files || photosBlock.currentTarget.files,
            reader = [],
            images = document.getElementById("images"),
            name;

        for (var i in files) {
            if (files.hasOwnProperty(i)) {
                name = "file" + i + "-certs";
                reader[i] = new FileReader();
                reader[i].readAsDataURL(photosBlock.files[i]);
                
                images.innerHTML += `<div class="form__label--photo">
                    <img id="${name}" src="" alt="" />
                </div>`;
                
                (function (name) {
                    reader[i].onload = function (e) {
                        document.getElementById(name).src = e.target.result;
                    };
                })(name);
            }
        }

        if (document.querySelector(".form__label--photo")) {
            document.querySelectorAll(".form__label--photo").forEach(element => {
                element.addEventListener("click", function() {
                    this.remove();
                })
            });
        }
    });

    if (document.querySelector(".form__label--photo")) {
        let currCertArray = JSON.parse(uploadedCerts),
            photoLabelList = document.getElementsByClassName("form__label--photo"),
            idUploadedCerts = document.querySelector("#uploaded-certs");
        
        idUploadedCerts.value = JSON.stringify(uploadedCerts);
        Array.prototype.forEach.call(photoLabelList, function (element, i) {
            element.addEventListener("click", function() {
                currCertArray.splice(i, 1, "");
                idUploadedCerts.value = JSON.stringify(currCertArray);
                this.remove();
            });
        });
    }

    document.querySelector(`[name="send-profile"]`).addEventListener("click", function() {
        var formData = new FormData(document.forms.questionnaire);
        var xhr = new XMLHttpRequest();

        xhr.open("POST", "/assets/php/addResource.php", true);

        xhr.onreadystatechange = function() {
            if (this.readyState != 4) return;
            let result = JSON.parse(this.responseText);

            alertDOM.classList.add("alert--" + result.state);
            alertDOM.innerHTML = result.message;
            alertDOM.style.display = "block";

            setTimeout(() => {
                alertDOM.style.display = null;
            }, 4000);
        }

        xhr.send(formData);
    });

    let sendInvite = document.querySelector(`a[data-action="sendInvite"]`);

    if (sendInvite) {
        sendInvite.addEventListener("click", function (e) {
            let	id_product = 321;
            let qty_product = 2;

            const request = new XMLHttpRequest();
            const url = "/assets/php/addUserInZoom.php";
            const params = `tarotEmail='~$_modx->getPlaceholder('upd.email')~'&tarotName='~$_modx->getPlaceholder('upd.fullname')~'&tarotID='~$_modx->getPlaceholder('upd.id')~'&questTarotID='~$userQuestResourse~'`

            request.open("POST", url, true);
            request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            request.addEventListener("readystatechange", () => {
                if(request.readyState === 4 && request.status === 200) {
                    document.querySelector(`[data-alert="invite"]`).innerHTML = "Ваша заявка успешно отправлена! После того, как ваша заявка обработается, вы получите на вашу электронную почту приглашение добавление в учетную запись Zoom.";
                }
            });
            
            request.send(params);
            e.preventDefault();
        });
    }

</script>')}