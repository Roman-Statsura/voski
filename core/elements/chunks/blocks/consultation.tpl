{set $checkRating = '!checkRating' | snippet : [
    'idTarot' => $consultIDTarot,
    'idConsult' => $idConsult,
    'getIDClient' => $.get.getIDClient,
]}

{if $checkRating == 'true' || $consultIDClient != $.get.getIDClient}
    {'@FILE snippets/Redirect.php' | snippet : [
        'id' => '1'
        'isAuth' => '0'
    ]}
{else}
    <div class="consultation">
        <div class="preloader">
            <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                <path fill="currentColor"
                    d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                </path>
            </svg>
        </div>

        {'@FILE chunks/elements/alerts.tpl' | chunk : [
            'fixed' => false,
            'noHiding' => 1
        ]}
        <div class="consultation-container__block consultation-block">
            <form id="ratingconsult" class="consultation-block__form">
                <input type="hidden" name="idTarot" value="{$consultIDTarot}">
                <input type="hidden" name="idClient" value="{$consultIDClient}">
                <input type="hidden" name="idConsult" value="{$idConsult}">
                <input type="hidden" name="getIDClient" value="{$.get.getIDClient}">

                <div class="consultation-block__body consultation-block-body">
                    <div class="consultation-block-body__title">
                        Оцените вашу последную сессию
                    </div>
                    <div class="consultation-block-body__content">
                        {set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                            'input' => $photo == '' ? '/assets/img/blocks/avatar.png' : $photo,
                            'options' => $optionThumb == '' ? 'w=275&zc=C&q=85' : $optionThumb
                        ]}

                        {set $thumbFromPhotoWebp = '@FILE snippets/pThumb/pthumb.php' | snippet : [
                            'input' => $photo == '' ? '/assets/img/blocks/avatar.png' : $photo,
                            'options' => $optionThumb == '' ? 'w=275&zc=C&q=85&f=webp' : $optionThumb ~ '&f=webp'
                        ]}
                        <div class="consultation-block__picture">
                            <picture>
                                <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                                <img class="consultation-block__image" src="{$thumbFromPhoto}" alt="" />
                            </picture>
                        </div>
                        <div class="consultation-block__name">
                            {$tarotName}
                        </div>
                        <div class="consultation-block__list">
                            <div class="consultation-block__item rating-css">
                                <div class="rating-css--icon">
                                    <input type="radio" name="rating" id="rating5" value="5">
                                    <label for="rating5" class="rating-css--star rating-css--star-1"></label>
                                    <input type="radio" name="rating" id="rating4" value="4">
                                    <label for="rating4" class="rating-css--star rating-css--star-2"></label>
                                    <input type="radio" name="rating" id="rating3" value="3">
                                    <label for="rating3" class="rating-css--star rating-css--star-3"></label>
                                    <input type="radio" name="rating" id="rating2" value="2">
                                    <label for="rating2" class="rating-css--star rating-css--star-4"></label>
                                    <input type="radio" name="rating" id="rating1" value="1">
                                    <label for="rating1" class="rating-css--star rating-css--star-5"></label>
                                </div>
                            </div>
                            <div class="consultation-block__item">
                                Консультация состоялась {$consultDatetime | strtotime | date: 'd.m.Y'}
                            </div>
                        </div>
                        <div class="consultation-block__buttons">
                            {'@FILE chunks/elements/button.tpl' | chunk : [
                                'type' => 'button'
                                'buttonTitle' => 'Оценить'
                                'dataAttr' => 'data-action="submit"'
                            ]}

                            {'@FILE chunks/elements/button.tpl' | chunk : [
                                'type' => 'link'
                                'link' => '/'
                                'buttonTitle' => 'Закрыть'
                                'theme' => 'dark'
                            ]}
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {$_modx->regClientScript('<script>
        document.body.classList.add("loaded");
        
        let button = document.querySelector(`[data-action="submit"]`),
            radioRatings = document.querySelectorAll(`[name="rating"]`);

        button.addEventListener("click", function (e) {
            e.preventDefault();
            document.body.classList.remove("loaded");

            var formData = new FormData(document.forms.ratingconsult);
            var xhr = new XMLHttpRequest();

            xhr.open("POST", "/assets/php/tarotRating.php", true);

            xhr.onreadystatechange = function() {
                if (this.readyState != 4) return;
                radioRatings.forEach(element => {
                    element.setAttribute("disabled", "disabled");
                });

                button.setAttribute("disabled", "disabled");

                document.body.classList.add("loaded");
                let result = JSON.parse(this.responseText);
                alerts(result);
            }

            xhr.send(formData);
        });
    </script>')}
{/if}