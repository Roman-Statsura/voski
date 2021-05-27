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
                <h2 class="login-content__header--title">Вход</h2>
                <div class="login-content__header--subtitle">
                    Пожалуйста, введите свой номер телефона, мы пришлём 
                    вам проверочный код
                </div>
            </div>
            <div class="login-content__body">
                {$errors}
        
                {'!Login' | snippet : [
                    'loginTpl' => 'lgnLoginTpl'
                    'logoutTpl' => 'lgnLogoutTpl'
                    'errTpl' => 'lgnErrTpl'
                    'actionKey' => 'action'
                    'loginKey' => 'login'
                    'redirectToPrior' => '0'
                    'loggedinResourceId' => '30'
                    'logoutResourceId' => '16'
                ]}
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