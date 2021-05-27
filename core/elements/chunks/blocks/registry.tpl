<div class="login wawe-container wawe-container-theme--white wawe-container--onlytop">
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
                            'activationEmailSubject' => 'Вы зарегистрированы на сайте Voski'
                            'submittedResourceId' => '20'
                            'placeholderPrefix' => ''
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