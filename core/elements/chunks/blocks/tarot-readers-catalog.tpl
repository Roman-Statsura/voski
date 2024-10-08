{set $JQueryJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/jquery-3.6.0.min.js'
]}
{set $filterJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/filter.js'
]}
{set $nouisliderJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/js/nouislider.min.js'
]}
{set $nouisliderCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => '/assets/css/nouislider.min.css'
]}

{set $JQueryJSPreload = '<link rel="preload" as="script" href="'~$JQueryJS~'">'}
{set $filterJSPreload = '<link rel="preload" as="script" href="'~$filterJS~'">'}
{set $nouisliderJSPreload = '<link rel="preload" as="script" href="'~$nouisliderJS~'">'}
{set $nouisliderCSSPreload = '<link rel="preload" as="script" href="'~$nouisliderCSS~'">'}
{set $nouisliderCSSLink = '<link href="'~$nouisliderCSS~'" rel="stylesheet">'}

{$JQueryJSPreload | htmlToHead: true}
{$filterJSPreload | htmlToHead: true}
{$nouisliderJSPreload | htmlToHead: true}
{$nouisliderCSSPreload | htmlToHead: true}
{$nouisliderCSSLink | htmlToHead: true}

{set $specList = 1 | resource : 'specList'}

{set $idsTarot = "22"}

<div class="tarot">
    <div class="tarot-container container">
        <div class="tarot-container__content tarot-content">
            <div class="tarot-content__header">
                <h2 class="tarot-content__header--title">Астрологи ОРАКУЛА</h2>
                <div class="tarot-content__header--subtitle">
                    Мы предоставляем персонализированный подбор астрологов. На нашем сайте Вы найдете только людей, 
                    прошедших курсы и подтвердивших свою квалификацию
                </div>
            </div>
            <div class="tarot-content__body">
                <div class="preloader">
                    <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor"
                            d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                        </path>
                    </svg>
                </div>
                <div class="tarot-content__filter tarot-content-filter">
                    <form action="" class="ajax-form" id="filterForm">
                        <div class="tarot-content-filter__row">
                            <div class="tarot-content-filter__col">
                                <label for="specialization" class="tarot-content-filter__label">Специализация</label>
                                <select class="form__input form__input--select login-tpl-form__item--input" name="specialization[]" id="specialization">
                                    <option value="0">Любой</option>
                                    {foreach $specList | json_decode: true as $key => $specItem}
                                        {if $specItem.active == 1}
                                            <option value="{$specItem.alias}">{$specItem.title}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                            <div class="tarot-content-filter__col">
                                <label for="experience" class="tarot-content-filter__label">Опыт работы</label>
                                <select class="form__input form__input--select login-tpl-form__item--input" name="experience" id="experience">
                                    <option value="0">Любой</option>
                                    <option value="0-5">0-5 лет</option>
                                    <option value="6-10">6-10 лет</option>
                                    <option value="10-20">10-20 лет</option>
                                    <option value="20+">20+ лет</option>
                                </select>
                            </div>
                            <div class="tarot-content-filter__col">
                                <label for="gender" class="tarot-content-filter__label">Пол астррлога</label>
                                <select class="form__input form__input--select login-tpl-form__item--input" name="gender" id="gender">
                                    <option value="0">Любой</option>
                                    <option value="male">Мужской</option>
                                    <option value="female">Женский</option>
                                </select>
                            </div>
                        </div>
                        <div class="tarot-content-filter__row flex-direction--column">
                            <label for="price" class="tarot-content-filter__label">
                                <div class="tarot-content-filter__label--title">Цена</div>
                                <div class="tarot-content-filter__label--range">
                                    <span data-action="minPrice"></span> - 
                                    <span data-action="maxPrice"></span> ₽
                                </div>
                            </label>
                            <input id="minPrice" name="price[]" class="form__input" type="hidden" value="">
                            <input id="maxPrice" name="price[]" class="form__input" type="hidden" value="">
                            <div data-action="rangeFilterPrice" class="tarot-content-filter__range ajax-range"></div>
                        </div>
                    </form>
                    <div class="tarot-content-filter__row">
                        <div class="tarot-content-filter--result">
                            По вашему запросу было найдено специалистов: <span data-action="filter-result" class="ajax-count">0</span>
                        </div>
                    </div>
                </div>
                <div class="tarot-readers-block__list ajax-container">
                    {'!tarotFilter' | snippet : [
                        'parents' => 2
                        'sortby' => 'publishedon'
                        'sortdir' => 'DESC'
                        'includeTVs' => 'specialization, experience, price, photo, gender, zoomID, rating'
                        'includeContent' => '1'
                        'tpl' => '@FILE chunks/elements/tarot-element.tpl'
                        'limit' => 0
                    ]}
                </div>
            </div>
        </div>
    </div>
    <div class="button-sticky container">
        {'@FILE chunks/elements/button.tpl' | chunk : [
            'type' => 'link'
            'buttonTitle' => 'Подберите мне астролога'
            'link' => 'select-tarot'
            'classes' => ''
        ]}
    </div>
</div>

{$_modx->regClientScript($nouisliderJS)}
{$_modx->regClientScript($JQueryJS)}
{$_modx->regClientScript($filterJS)}

{$_modx->regClientScript('<script>
    document.addEventListener("DOMContentLoaded", function () {
        document.body.classList.add("loaded");

        var slider = document.querySelector(`[data-action="rangeFilterPrice"]`),
            inputList = document.querySelectorAll(".form__input"),
            maxPrice = ' ~ $_modx->getPlaceholder("maxPrice") ~ ',
            minInput = document.querySelector(`[data-action="minPrice"]`),
            maxInput = document.querySelector(`[data-action="maxPrice"]`);

        noUiSlider.create(slider, {
            start: [0, maxPrice],
            connect: true,
            step: 1,
            range: {
                "min": 0,
                "max": maxPrice
            }
        });

        slider.noUiSlider.on("update", function (values, handle) {
            minInput.innerHTML = Number(values[0]).toFixed(0);
            maxInput.innerHTML = Number(values[1]).toFixed(0);
            document.querySelector(`#minPrice`).value = Number(values[0]).toFixed(0);
            document.querySelector(`#maxPrice`).value = Number(values[1]).toFixed(0);
        });
    });
</script>', true)}