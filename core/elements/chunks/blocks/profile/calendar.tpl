{set $watchJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/object-watch.js'
]}

{set $calendarJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/calendar.js'
]}

{set $watchJSPreload = '<link rel="preload" as="script" href="'~$watchJS~'">'}
{set $calendarJSPreload = '<link rel="preload" as="script" href="'~$calendarJS~'">'}

{$watchJSPreload | htmlToHead: true}
{$calendarJSPreload | htmlToHead: true}

{'!UpdateProfile' | snippet : [
    'validate' => ''
    'placeholderPrefix' => 'upd.'
    'submitVar' => 'login-updprof-btn'
]}

{set $userQuestResourse = '@FILE snippets/findUserAndReview.php' | snippet : [
    'id' => $_modx->getPlaceholder('upd.id')
]}

<div class="login">
    <div class="login-container login-container--100 container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                {'@FILE chunks/elements/alerts.tpl' | chunk : [
                    'fixed' => true
                ]}
                <h2 class="login-content__header--title">Календарь</h2>
                <div class="login-content__header--subtitle">
                    Здесь отображаются записи к вам.<br>
                    Вы можете следить и управлять своим расписанием.
                </div>
            </div>
            <div class="login-content__body">
                {'@FILE chunks/blocks/schedule.tpl' | chunk}

                <div class="calendar-content__header">
                    <div class="calendar-content__header--middle">
                        <button type="button" class="calendar-content__button" data-action="prev">
                            {'@FILE chunks/icons/icon-arrow-left.tpl' | chunk}
                        </button>

                        <div data-action="title" class="calendar-content__title"></div>
                        
                        <button type="button" class="calendar-content__button" data-action="next">
                            {'@FILE chunks/icons/icon-arrow-right.tpl' | chunk}
                        </button>
                    </div>
                </div>
                {set $schedule = $userQuestResourse | resource: 'schedule'}
                {set $schedule = count($schedule | json_decode: true) == 0 ? '0' : $schedule}
                {set $newSchedule = []}
                {foreach $schedule | json_decode: true as $sch}
                    {if $sch.idUser != ""}
                        {set $sch.username = '@FILE snippets/getUserNameByID.php' | snippet : [
                            'id' => $sch.idUser
                            'field' => 'fullname'
                        ]}
                        {set $sch.gender = '@FILE snippets/getUserNameByID.php' | snippet : [
                            'id' => $sch.idUser
                            'field' => 'gender'
                        ]}
                        {set $sch.age = '@FILE snippets/getUserNameByID.php' | snippet : [
                            'id' => $sch.idUser
                            'extended' => 1
                            'field' => 'age'
                        ]}
                    {/if}

                    {set $newSchedule[] = $sch}
                {/foreach}

                <div id="calendar"></div>
            </div>
        </div>
    </div>
</div>

{$_modx->regClientScript($watchJS)}
{$_modx->regClientScript($calendarJS)}

{$_modx->regClientScript('<script>
    let userData = {
        id: ' ~ $userQuestResourse ~ ',
        schedule: ' ~ $newSchedule | json_encode: true ~ '
    };
</script>', true)}