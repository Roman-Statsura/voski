{set $JQueryJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/jquery-3.6.0.min.js'
]}
{set $filterJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/filter.js'
]}

{set $JQueryJSPreload = '<link rel="preload" as="script" href="'~$JQueryJS~'">'}
{set $filterJSPreload = '<link rel="preload" as="script" href="'~$filterJS~'">'}

{$JQueryJSPreload | htmlToHead: true}
{$filterJSPreload | htmlToHead: true}

<div class="login wawe-container wawe-container-theme--white wawe-container--onlytop">
    <div class="login-container login-container--wide container">
        <div class="login-container__content login-content">
            <div class="login-content__header">
                {'@FILE chunks/elements/alerts.tpl' | chunk : [
                    'fixed' => true
                ]}
                <h2 class="login-content__header--title" data-text="title">Выбор своих проблем</h2>
                <div class="login-content__header--subtitle" data-text="subtitle">
                    Выберите 2-4 запроса, которые вас интересуют. Так мы сможем наиболее точно подобрать специалистов
                </div>
            </div>
            <div class="login-content__body"> 
                <form id="select-tarot" class="form login-tpl-content__form login-form ajax-form" action="" method="post">
                    <div class="login-tab tab active" data-id="1" data-parent="1" type-form="registration">
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_1" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="work" required />
                            <label for="questionnaire_1" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Положение с финансами</div>
                                    <div class="form__label--text">Разобраться в сложившейся ситуации, улучшить, перспективы</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_2" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="introspection" required />
                            <label for="questionnaire_2" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Взаимоотношения с собой</div>
                                    <div class="form__label--text">Раскрыть свой потенциал, личностное развитие</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_3" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="future" required />
                            <label for="questionnaire_3" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мои планы на ближайшее время</div>
                                    <div class="form__label--text">Месяц, год, 3-5 лет</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_4" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="work" required />
                            <label for="questionnaire_4" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Моя карьера</div>
                                    <div class="form__label--text">Произошедшее и планируемое</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_5" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="introspection" required />
                            <label for="questionnaire_5" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мое развитие и самоопределение</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_6" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="advice" required />
                            <label for="questionnaire_6" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Важные изменения в жизни</div>
                                    <div class="form__label--text">Произошедшие или планируемые</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_7" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="physical-health" required />
                            <label for="questionnaire_7" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мое физическое состояние</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_8" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="" required />
                            <label for="questionnaire_8" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мое прошлое</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_9" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="friendship" required />
                            <label for="questionnaire_9" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Отсутствие отношений</div>
                                    <div class="form__label--text">Консультация на отношения и личную жизнь</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_10" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="friendship" required />
                            <label for="questionnaire_10" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мои отношения с партнером</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_11" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="friendship" required />
                            <label for="questionnaire_11" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мои отношения с родителями</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_12" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="friendship" required />
                            <label for="questionnaire_12" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мои отношения с детьми</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_13" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="friendship" required />
                            <label for="questionnaire_13" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мои отношения с другими людьми</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_14" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="advice" required />
                            <label for="questionnaire_14" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Совет, предостережение в ситуации</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_15" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="work" required />
                            <label for="questionnaire_15" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мой бизнес</div>
                                    <div class="form__label--text">Произошедшее и планируемое</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_16" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="future" required />
                            <label for="questionnaire_16" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Исполнение желания</div>
                                    <div class="form__label--text">Возможности и перспективы</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="questionnaire_17" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="specialization[]" value="physical-health" required />
                            <label for="questionnaire_17" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Мое физическое и энергетическое здоровье</div>
                                </div>
                            </label>
                        </div>
                        
                        <div class="login-tpl-form__item justify-content--flex-start">
                            <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="next" data-id="2" data-parent="1" type-form="gender-tarot" value="Следующий шаг" />
                        </div>
                    </div>

                    <div class="login-tab tab" data-id="2" data-parent="1" type-form="gender-tarot">
                        <div class="login-tpl-form__item">
                            <input id="gender-tarot_1" class="form__radio login-tpl-form__item--input" type="radio" name="gender" value="1" required />
                            <label for="gender-tarot_1" class="form__label login-tpl-form__item--label">
                                <div class="form__label--title">Мужской</div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="gender-tarot_2" class="form__radio login-tpl-form__item--input" type="radio" name="gender" value="2" required />
                            <label for="gender-tarot_2" class="form__label login-tpl-form__item--label">
                                <div class="form__label--title">Женский</div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="gender-tarot_3" class="form__radio login-tpl-form__item--input" type="radio" name="gender" value="0" required />
                            <label for="gender-tarot_3" class="form__label login-tpl-form__item--label">
                                <div class="form__label--title">Не важно</div>
                            </label>
                        </div>
                        
                        <div class="login-tpl-form__item justify-content--flex-start">
                            <input class="button button-size--normal button-theme--dark login-tpl-form__item--button" type="button" name="prev" data-id="1" data-parent="1" type-form="questionnaire" value="Назад" />
                            <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="next" data-id="3" data-parent="1" type-form="price-tarot" value="Следующий шаг" />
                        </div>
                    </div>
                    
                    <div class="login-tab tab" data-id="3" data-parent="1" type-form="price-tarot">
                        <div class="login-tpl-form__item">
                            <input id="price_1" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="price[]" value="2000-3000" required />
                            <label for="price_1" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">2 000 – 3 000 ₽</div>
                                    <div class="form__label--text">Менее года частной практики, последние годы обучения или недавние выпускники. Хорошо справятся с запросами на самоопределение, обретение своих интересов.</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="price_2" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="price[]" value="3000-7000" required />
                            <label for="price_2" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">3 000 – 7 000 ₽</div>
                                    <div class="form__label--text">1-3 года частной практики, тарологи с потенциалом. Помогут с переживанием кризисных ситуаций, тревогой.</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="price_3" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="price[]" value="7000-10000" required />
                            <label for="price_3" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">7 000 – 10 000 ₽</div>
                                    <div class="form__label--text">От 10 лет частной практики или широкое признание профессионального сообщества, опыт работы с собственниками бизнеса или топ-менеджерами, члены международных профессиональных объединений</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="price_4" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="price[]" value="10000-20000" required />
                            <label for="price_4" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">10 000 – 20 000 ₽</div>
                                    <div class="form__label--text">От 10 лет частной практики или широкое признание профессионального сообщества, опыт работы с собственниками бизнеса или топ-менеджерами, члены международных профессиональных объединений</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item">
                            <input id="price_5" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="price[]" value="0" required />
                            <label for="price_5" class="form__label login-tpl-form__item--label">
                                <div class="form__label--group">
                                    <div class="form__label--title">Цена НЕ ВАЖНА</div>
                                    <div class="form__label--text">Выберите, если цена консультации не имеет для вас значения.</div>
                                </div>
                            </label>
                        </div>
                        <div class="login-tpl-form__item justify-content--flex-start">
                            <input class="button button-size--normal button-theme--dark login-tpl-form__item--button" type="button" name="prev" data-id="2" data-parent="1" type-form="gender-tarot" value="Назад" />
                            <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" type="button" name="next" data-id="4" data-parent="1" type-form="select-tarot" value="Следующий шаг" />
                        </div>
                    </div>

                    <div class="login-tab tab" data-id="4" data-parent="1" type-form="select-tarot">
                        {set $objs = 29 | resource: 'qa' | json_decode: true}
                        <div class="faq-content__list">
                            {foreach $objs as $key => $item}
                                {if $item.active == 1}
                                    <div class="faq-content__item hidden">
                                        <div class="faq-content__item-question">{$item.question}</div>
                                        <div class="faq-content__item-answer">
                                            {$item.answer}
                                        </div>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="select-tarot__block tarot-readers-block__list ajax-container">
                            {'!tarotFilter' | snippet : [
                                'parents' => 2
                                'sortby' => 'publishedon'
                                'sortdir' => 'DESC'
                                'includeTVs' => 'specialization, experience, price, photo, gender, zoomID, rating'
                                'includeContent' => '1'
                                'tpl' => '@FILE chunks/elements/tarot-element.tpl'
                                'limit' => 5
                            ]}
                            <div class="tarot-readers-block__item ajax-item">
                                <div class="tarot-readers-block__info justify-content--center">
                                    <h3 class="tarot-readers-block__name">
                                        Каталог тарологов
                                    </h3>
                                    <div class="tarot-readers-block__text">
                                        Не нашли подходящего тарголога через анкету? Посмотрите в каталоге
                                    </div>
                            
                                    <div class="tarot-readers-block__buttons">
                                        {'@FILE chunks/elements/button.tpl' | chunk : [
                                            'buttonTitle' => 'Перейти в каталог'
                                            'type' => 'link'
                                            'link' => $_modx->makeUrl(2)
                                        ]}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

{$_modx->regClientScript($JQueryJS)}
{$_modx->regClientScript($filterJS)}

{$_modx->regClientScript('<script>
    let steps = document.querySelectorAll("input[data-id]"),
        container = document.querySelector(".login-container"),
        headerStep = document.querySelectorAll(".login-steps-content__step"),
        tabs = document.querySelectorAll(`.login-tab`),
        title = document.querySelector(".login-content__header--title"),
        subtitle = document.querySelector(".login-content__header--subtitle"),
        inputs = document.querySelectorAll(`.login-tpl-form__item--input`),
        alertDOM = document.querySelector(`[data-action="alert"]`),
        activeStep = 1,
        error = true,
        headers = [{
            title: "Выбор своих проблем",
            subtitle: "Выберите 2-4 запроса, которые вас интересуют. Так мы сможем наиболее точно подобрать специалистов",
            container: ""
        }, {
            title: "Выбор пола таролога",
            subtitle: "Выберите пол тпролога, с которым вы хотели бы провести занятие. Так мы сможем наиболее точно подобрать специалистов",
            container: ""
        }, {
            title: "Сколько комфортно платить за сессию?",
            subtitle: "Количество часов для каждого клиента определяется индивидуально: в зависимости от проблемы, которую предстоит решать, и метода, в котором работает специалист.<br>Цена указана за сессию.",
            container: ""
        }, {
            title: "Выбор таролога",
            subtitle: "",
            container: "login-container--full"
        }];

    let faqItems = document.querySelectorAll(".faq-content__item");

    faqItems.forEach(element => {
        element.addEventListener("click", function () {
            this.classList.toggle("hidden");
        });
    });

    steps.forEach(element => {
        element.addEventListener("click", function () {
            checkedLenght = 0;
            inputs.forEach(element => {
                if (element.offsetParent !== null) {
                    if (!element.checked) {
                        element.classList.add("invalid");
                        error = true;
                        alerts({
                            state: "error",
                            message: "Выберите хотя бы один вариант"
                        });
                    } else {
                        element.classList.remove("invalid");
                        checkedLenght += 1;
                    }
                }
            });

            if (checkedLenght > 0) {
                error = false;
                clearAlert();

                inputs.forEach(element => {
                    if (element.offsetParent !== null) {
                        element.classList.remove("invalid");
                    }
                });
            }

            if (!error) {
                activeStep = Number(this.dataset.id);
                title.innerHTML = headers[Number(this.dataset.id) - 1].title;
                subtitle.innerHTML = headers[Number(this.dataset.id) - 1].subtitle;

                headerStep.forEach(elem => {
                    elem.classList.remove("active");
                });

                if (headers[Number(this.dataset.id) - 1].container !== "") {
                    container.classList.remove("login-container--wide");
                    container.classList.add("login-container--100");
                }
                document.querySelector(`.login-steps-content__step[data-id="${this.dataset.id}"]`).classList.add("active");

                tabs.forEach(elem => {
                    elem.classList.remove("active");
                });
                document.querySelector(`.login-tab[data-id="${this.dataset.id}"]`).classList.add("active");
            }
        });
    });
</script>', true)}