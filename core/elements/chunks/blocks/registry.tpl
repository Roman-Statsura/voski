<div class="login wawe-container wawe-container-theme--white wawe-container--onlytop">
    <div class="preloader">
        <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
            <path fill="currentColor"
                d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
            </path>
        </svg>
    </div>
    <div class="login-container login-container--wide container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                <h2 class="login-content__header--title" data-text="title">Регистрация</h2>
                <div class="login-content__header--subtitle" data-text="subtitle">
                    Давайте знакомиться!
                </div>
            </div>
            <div class="login-content__body">    
                {if $modx->user->isAuthenticated()}
                    {'@FILE snippets/Redirect.php' | snippet : [
                        'id' => '22'
                        'isAuth' => '1'
                    ]}
                {else}
                    {set $sessionUsername = '@FILE snippets/session.php' | snippet : [
                        'name' => 'username'
                    ]}

                    {set $sessionUserGroup = '@FILE snippets/session.php' | snippet : [
                        'name' => 'userGroup'
                    ]}

                    {if $sessionUsername != ""}
                        {'!Register' | snippet : [
                            'submitVar' => ''
                            'activationResourceId' => '19'
                            'activationEmailTpl' => 'lgnActivateEmailTpl'
                            'activationEmailSubject' => 'Вы зарегистрированы на сайте ОРАКУЛ'
                            'submittedResourceId' => '20'
                            'placeholderPrefix' => 'reg.'
                            'usergroups' => $sessionUserGroup
                            'successMsg' => '<div class="alert alert-success">Спасибо за регистрацию.</div>'
                            'usernameField' => 'phone'
                            'validate' => 'fullname:required:minLength=^6^,email:required,password:required:minLength=^6^,password_confirm:password_confirm=^password^'
                        ]}

                        {$error.message ?: $_modx->getChunk('lgnRegisterFormTpl')}
                    {else}
                        {'@FILE snippets/Redirect.php' | snippet : [
                            'id' => '16'
                            'isAuth' => '0'
                        ]}
                    {/if}
                {/if}
            </div>
        </div>
    </div>
</div>