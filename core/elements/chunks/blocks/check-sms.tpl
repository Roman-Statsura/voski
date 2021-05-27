<div class="login">
    <div class="login-container container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                <h2 class="login-content__header--title">Вход</h2>
                <div class="login-content__header--subtitle">
                    Пожалуйста, введите свой номер телефона, мы пришлём 
                    вам проверочный код
                </div>
            </div>
            <div class="login-content__body">
                {*'@FILE snippets/login/Login.php' | snippet *}

                {'!Login' | snippet : [
                    'loginTpl' => '@FILE chunks/components/login/lgnLoginTpl2.tpl'
                ]}

                {* [[!Login? 
                    &loginTpl=`Auth.Login` 
                    &logoutTpl=`Auth.Logout` 
                    &errTpl=`Auth.Login.Error`
                    &actionKey=`action` 
                    &loginKey=`login`
                    &loginResourceId=`5`
                    &redirectToPrior=`0` 
                    &logoutResourceId=`1`
                ]] *}
            </div>
        </div>
    </div>
</div>
