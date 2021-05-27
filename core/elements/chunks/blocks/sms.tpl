{set $sessionUsername = '@FILE snippets/session.php' | snippet : [
    'name' => 'readUsername'
]}
{set $sessionError = '@FILE snippets/session.php' | snippet : [
    'name' => 'error'
]}

<div class="login">
    <div class="login-container container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                {if $sessionError != ""}
                    {'@FILE chunks/elements/alerts.tpl' | chunk : [
                        'noHiding' => 1
                    ]}
                {/if}
                <h2 class="login-content__header--title">Введите код</h2>
                <div class="login-content__header--subtitle">
                    Код был выслан на номер <span>{$sessionUsername}</span>
                </div>
            </div>
            <div class="login-content__body">
                {if $modx->user->isAuthenticated()}
                    {'@FILE snippets/Redirect.php' | snippet : [
                        'id' => '1'
                        'isAuth' => '1'
                    ]}
                {else}
                    {if $_modx->config['Login.SMSAuth']}
                        {set $sessionUsername = '@FILE snippets/session.php' | snippet : [
                            'name' => 'username'
                        ]}

                        {if $sessionUsername != ""}
                            {'!Login' | snippet : [
                                'loginTpl' => 'lgnSMSLogin'
                                'logoutTpl' => 'lgnLogoutTpl'
                                'errTpl' => 'lgnErrTpl'
                                'actionKey' => 'action'
                                'loginKey' => 'login'
                                'loginResourceId' => '16'
                                'redirectToPrior' => '0'
                                'logoutResourceId' => '1'
                            ]}
                        {else}
                            {'@FILE snippets/Redirect.php' | snippet : [
                                'id' => '16'
                                'isAuth' => '0'
                            ]}
                        {/if}
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

{if $sessionError != ""}
    {$_modx->regClientScript('<script>
        alerts({
            state: `'~$sessionError["state"]~'`,
            message: `'~$sessionError["message"]~'`
        });
    </script>', true)}
{/if}