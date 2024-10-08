{$logcp.error_message != '' ? '<p style="color: red;">$logcp.error_message</p>' : ''}

<form class="form inline" action="{$_modx->makeUrl($_modx->resource.id)}" method="post">
    <input type="hidden" name="nospam:blank" value="" />
    <input type="hidden" name="lp" value="{$logcp.lp}"/>
    <input type="hidden" name="lu" value="{$logcp.lu}"/>

    <div class="ff">
        <label for="password_new">{$_modx->lexicon('login.password_new')}
            <span class="error">{$logcp.error.password_new}</span>
        </label>
        <input type="password" name="password_new:required" id="password_new" value="{$logcp.password_new}" />
    </div>

    <div class="ff">
        <label for="password_new_confirm">{$_modx->lexicon('login.password_new_confirm')}
            <span class="error">{$logcp.error.password_new_confirm}</span>
        </label>
        <input type="password" name="password_new_confirm:required" id="password_new_confirm" value="{$logcp.password_new_confirm}" />
    </div>

    <br class="clear" />

    <div class="form-buttons">
        <input type="submit" name="logcp-submit" value="[[!%login.change_password]]" />
    </div>
</form>