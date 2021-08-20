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
    <div class="login-container login-container--full container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                <h2 class="login-content__header--title">Сообщения</h2>
                <div data-action="msgAlert" class="alert">
                    Анкета не отправленна на модерацию
                </div>
                <div class="login-content__header--subtitle">
                    Здесь отображаются ваши сообщения
                </div>
            </div>
            <div class="login-content__body">
                {if $_modx->user.extended.usertype == 3}
                    {set $userQuestResourse = '@FILE snippets/findUserAndReview.php' | snippet : [
                        'id' => $_modx->getPlaceholder('upd.internalKey')
                    ]}
                {else}
                    {set $userQuestResourse = $_modx->getPlaceholder('upd.internalKey')}
                {/if}

                {set $messages = 1 | resource : 'messages' | json_decode: true}

                <div class="table-flex">
                    <div class="table-flex--row table-flex--head">
                        <div class="table-flex--col">Дата</div>
                        <div class="table-flex--col">От кого</div>
                        <div class="table-flex--col">Сообщение</div>
                        <div class="table-flex--col"></div>
                    </div>
                    {set $countMessages = 0}
                    {foreach $messages as $key => $message}
                        {if ($_modx->user.extended.usertype == 3 && $message.toUser == $userQuestResourse) || ($_modx->user.extended.usertype == 2 && $message.fromUser == $_modx->getPlaceholder('upd.internalKey'))}
                            {if $message.active == 1}
                                {set $countMessages += 1}
                                {set $userFullname = '@FILE snippets/getUserNameByID.php' | snippet : [
                                    'id' => $message.fromUser
                                    'field' => 'fullname'
                                ]}
                            
                                <div class="table-flex--row table-flex--body" data-message="msgid-{$key}">
                                    <div class="table-flex--item">
                                        <div class="table-flex--col message-date">{$message.date | date: 'd.m.Y'}</div>
                                        <div class="table-flex--col">{$userFullname}</div>
                                        <div class="table-flex--col message-text">
                                            {$message.text}
                                            {if $message.fromUser != $userQuestResourse}
                                                <a href="#" data-nmodal="msgAnswer" data-author="{$message.fromUser}" data-nmodal-size="large" class="link--theme--mint">Ответить »</a>
                                            {/if}
                                        </div>
                                        <div class="table-flex--col message--col">
                                            {if $message.answers != "" && count($message.answers) > 0}
                                                <div class="message-count" data-action="msgid-{$key}">
                                                    {count($message.answers)}
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                    {foreach $message.answers as $answers}
                                        {if $answers.active == 1} 
                                            {set $countMessages += 1}

                                            {set $answerFullname = '@FILE snippets/getUserNameByID.php' | snippet : [
                                                'id' => $answers.idUser
                                                'field' => 'fullname'
                                            ]}
                                            <div class="table-flex--row table-flex--item table-flex--answers">
                                                <div class="table-flex--col">{$answers.date | date: 'd.m.Y'}</div>
                                                <div class="table-flex--col">
                                                    {if $answerFullname == ""}
                                                        {$answers.idUser | resource: 'pagetitle'}
                                                    {else}
                                                        {$answerFullname}
                                                    {/if}
                                                </div>
                                                <div class="table-flex--col message-text">
                                                    {$answers.text}
                                                    {if $answers.idUser != $userQuestResourse}
                                                        <a href="#" data-nmodal="msgAnswer" data-nmodal-size="large" class="link--theme--mint">Ответить »</a>
                                                    {/if}
                                                </div>
                                                <div class="table-flex--col"></div>
                                            </div>    
                                        {/if}
                                    {/foreach}
                                </div>    
                            {/if}   
                        {/if}
                    {/foreach}
                    
                    {if $countMessages == 0}
                        <div class="table-flex--row table-flex--body">
                            <div class="table-flex--col table-flex--col--full">На данный момент, сообщений нет</div>
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

<div id="msgAnswer" class="nModal">
    <form id="message" action="">
        {if $_modx->user.extended.usertype == 3}
            <input type="hidden" name="idUser" value="{$userQuestResourse}">
        {else}
            <input type="hidden" name="idUser" value="{$_modx->getPlaceholder('upd.internalKey')}">
        {/if}
        <div class="nModal-header">
            <div class="nModal-header__title">Написать сообщение</div>
            <a href="#" class="nModal-button nModal-button--close" data-nmodal-callback="closeModal">{'@FILE chunks/icons/icon-cross.tpl' | chunk}</a>
        </div>
        <div class="nModal-body">
            <div style="display: none;" class="nModal-body__form--item">
                <label for="msgUsername">Кому:</label>
                <input type="text" class="form__input" name="msgUsername" id="msgUsername" placeholder="Кому..." value="{$message.idUser}">
            </div>
            <div class="nModal-body__form--item">
                <textarea name="msgText" class="form__input" id="msgText" cols="30" rows="6" placeholder="Введите"></textarea>
            </div>
        </div>
        <div class="nModal-buttons">
            <a href="" class="nModal-button button button-size--normal button-theme--mint" data-nmodal-callback="callback">Отправить </a>
        </div>
    </form>
</div>


{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/native-modals.js'
])}

{$_modx->regClientScript('<script>
    document.addEventListener("DOMContentLoaded", function () {        
        nModal.init({
            watch: true,
            backdrop: true
        });
    });

    let messagesCount = document.querySelectorAll(".message-count"),
        msgBlocks = document.querySelectorAll("[data-message]");

    messagesCount.forEach(element => {
        element.addEventListener("click", function(e) {
            document.querySelector(`[data-message="${this.dataset.action}"]`).classList.toggle("opened");
        });
    });

    function closeModal() {
        nModal.close();
    }

    function callback(formElement) {
        let alertDOM = document.querySelector(`[data-action="msgAlert"]`),
            formData = new FormData(document.forms.message),
            xhr = new XMLHttpRequest();

        xhr.open("POST", "/assets/php/messages.php", true);

        xhr.onreadystatechange = function() {
            if (this.readyState != 4) return;
            let result = JSON.parse(this.responseText);

            alertDOM.classList.add("alert--" + result.state);
            alertDOM.innerHTML = result.message;
            alertDOM.style.display = "block";

            setTimeout(() => {
                alertDOM.style.display = null;
            }, 4000);
            
            nModal.close();
        }

        xhr.send(formData);
    }
</script>', true)}