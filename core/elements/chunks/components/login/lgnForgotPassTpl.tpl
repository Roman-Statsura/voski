<div class="loginFPErrors">{$loginfp.errors}</div>
<div class="loginFP">
    <form class="loginFPForm" action="{$_modx->makeUrl($_modx->resource.id)}" method="post">
        <fieldset class="loginFPFieldset">
            <legend class="loginFPLegend">{$_modx->lexicon('login.forgot_password')}</legend>
            <label class="loginFPUsernameLabel">{$_modx->lexicon('login.username')}
                <input class="loginFPUsername" type="text" name="username" value="{$loginfp.post.username}" />
            </label>
            
            <p>{$_modx->lexicon('login.or_forgot_username')}</p>
            
            <label class="loginFPEmailLabel">{$_modx->lexicon('login.email')}
                <input class="loginFPEmail" type="text" name="email" value="{$loginfp.post.email}" />
            </label>
            
            <input class="returnUrl" type="hidden" name="returnUrl" value="{$loginfp.request_uri}" />
            
            <input class="loginFPService" type="hidden" name="login_fp_service" value="forgotpassword" />
            <span class="loginFPButton"><input type="submit" name="login_fp" value="{$_modx->lexicon('login.reset_password')}" /></span>
        </fieldset>
    </form>
</div>