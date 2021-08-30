{set $userQuestResourse = '@FILE snippets/findUserAndReview.php' | snippet : [
    'id' => $_modx->getPlaceholder('upd.internalKey')
]}

{'@FILE snippets/hoursRange.php' | snippet}

{set $worktime = $userQuestResourse | resource: 'worktime'}
{set $worktime = $worktime | json_decode: 'true'}

{set $worktimeSchedule = '[
    {
        "dayweek": "monday",
        "title": "Понедельник"
    }, {
        "dayweek": "tuesday",
        "title": "Вторник"
    }, {
        "dayweek": "wednesday",
        "title": "Среда"
    }, {
        "dayweek": "thursday",
        "title": "Четверг"
    }, {
        "dayweek": "friday",
        "title": "Пятница"
    }, {
        "dayweek": "saturday",
        "title": "Суббота"
    }, {
        "dayweek": "sunday",
        "title": "Воскресенье"
    }
]' | json_decode: 'true'}

<form id="worktime" method="POST">
    <input type="hidden" name="idUser" value="{$_modx->getPlaceholder('upd.internalKey')}">
    <div class="display__flex justify-content--center flex-direction--column">
        {foreach $worktimeSchedule as $key => $worktimeItem}
            <div class="login-tpl-form__item justify-content--center">
                <div class="login-tpl-form__item--left width__175px align-item--flex-start">
                    <input id="dayweek_{$key}" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="dayweek[]" value="{$worktimeItem.dayweek}" {$worktime[$key]["active"] ? "checked" : ""} />
                    <label for="dayweek_{$key}" class="form__label login-tpl-form__item--label">
                        <div class="form__label--group">
                            <div class="form__label--title">{$worktimeItem.title}</div>
                        </div>
                    </label>
                </div>
                <div class="login-tpl-form__item--right width__auto flex-direction--row">
                    {set $startTime = '@FILE snippets/timeByTimezone.php' | snippet : [
                        'time' => $worktime[$key]['time']
                    ]}

                    {'@FILE chunks/elements/timepicker.tpl' | chunk : [
                        'name' => 'time['~$worktimeItem.dayweek~']',
                        'attrs' => $worktime[$key]["active"] ? "" : "disabled",
                        'value' => $startTime,
                        'id' => 'time_'~$key,
                        'classesList' => 'timepicker_start'
                    ]}
                    
                    <span class="calendar-date__times--delimeter">-</span>

                    {set $endTime = '@FILE snippets/timeByTimezone.php' | snippet : [
                        'time' => $worktime[$key]['timeEnd']
                    ]}

                    {'@FILE chunks/elements/timepicker.tpl' | chunk : [
                        'name' => 'timeEnd['~$worktimeItem.dayweek~']',
                        'attrs' => $worktime[$key]["active"] ? "" : "disabled",
                        'value' => $endTime,
                        'id' => 'timeEnd_'~$key,
                        'classesList' => 'timepicker_end'
                    ]}
                </div>
            </div>
        {/foreach}
        <div class="login-tpl-form__item justify-content--center">
            {'@FILE chunks/elements/button.tpl' | chunk : [
                'buttonTitle' => 'Сохранить график'
                'dataAttr' => 'id="submitWorktime" type="button"'
            ]}
        </div>
    </div>
</form>

{$_modx->regClientScript('<script>
    let dayweekCheckboxes = document.querySelectorAll(`[name="dayweek[]"]`),
        times = document.querySelectorAll(`[name="time[]"]`),
        timesEnd = document.querySelectorAll(`[name="timeEnd[]"]`),
        timepickerInput = document.querySelectorAll(`.timepicker_input`),
        submitWorktime = document.querySelector(`#submitWorktime`);

    dayweekCheckboxes.forEach(element => {
        element.addEventListener("change", function() {
            let currentID = this.id,
                idsBlock = currentID.split("_"),
                detectedTimeInput = document.querySelector(`#time_${idsBlock[1]}`),
                detectedTimeEndInput = document.querySelector(`#timeEnd_${idsBlock[1]}`);

            if (detectedTimeInput.hasAttribute("disabled")) {
                detectedTimeInput.removeAttribute("disabled");
                detectedTimeEndInput.removeAttribute("disabled");
            } else {
                detectedTimeInput.setAttribute("disabled", "disabled");
                detectedTimeEndInput.setAttribute("disabled", "disabled");
            }
        });
    });

    function hideTimepicker(elem) {
        let currentID = elem.id,
            idsBlock = currentID.split("_"),
            detectedTimeInput = document.querySelector(`#time_${idsBlock[1]}`),
            detectedTimeEndInput = document.querySelector(`#timeEnd_${idsBlock[1]}`),
            timeInputOption = detectedTimeInput.querySelectorAll(`option`),
            timeEndInputOption = detectedTimeEndInput.querySelectorAll(`option`);

        for (let item of detectedTimeEndInput.querySelectorAll(`option`)) {
            item.removeAttribute("disabled", "");
            item.removeAttribute("hidden", "");
            item.classList.remove("hidden-option");
        }

        for (let i = 0; i < timeEndInputOption.length; i++) {
            timeEndInputOption[i].setAttribute("disabled", "");
            timeEndInputOption[i].setAttribute("hidden", "");
            timeEndInputOption[i].classList.add("hidden-option");

            if (timeEndInputOption[i].value === detectedTimeInput.value) {
                break;
            }
        }
    }

    timepickerInput.forEach(element => {
        hideTimepicker(element);
    });

    timepickerInput.forEach(element => {
        element.addEventListener("change", function() {
            hideTimepicker(this);
        });
    });

    submitWorktime.addEventListener("click", function() {
        callbackWorktime(document.forms.worktime);
    });

    function callbackWorktime(formElement) {        
        let formData = new FormData(formElement),
            xhr = new XMLHttpRequest();

        xhr.open("POST", "/assets/php/addWorktime.php", true);
        xhr.onreadystatechange = function() {
            if (this.readyState != 4) return;

            let result = JSON.parse(this.responseText);
            alerts({
                state: result.state,
                message: result.message
            });
        }
        xhr.send(formData);
    }
</script>', true)}