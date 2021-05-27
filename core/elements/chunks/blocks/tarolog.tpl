<div class="tarolog wawe-container wawe-container-theme--white">
    <div class="tarolog-container container">
        <div class="tarolog-container__content tarolog-content">
            <div class="tarolog-content__header">
                <h2 class="tarolog-content__header--title">В нашей базе 235 лучших таргологов</h2>
            </div>
            <div class="tarolog-content__body">
                <div class="tarolog-content__block tarolog-content__items">
                    {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                        'imageField' => '/assets/img/tarolog/tarolog-1.png'
                    ]}
                    {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                        'imageField' => '/assets/img/tarolog/tarolog-2.png'
                    ]}
                    {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                        'imageField' => '/assets/img/tarolog/tarolog-3.png'
                    ]}
                    {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                        'imageField' => '/assets/img/tarolog/tarolog-4.png'
                    ]}
                    {'@FILE chunks/elements/tarolog-photo.tpl' | chunk : [
                        'imageField' => '/assets/img/tarolog/tarolog-5.png'
                    ]}
                </div>
                <div class="tarolog-content__block">
                    {'@FILE chunks/elements/button.tpl' | chunk : [
                        'buttonTitle' => 'Подобрать своего таролога'
                        'type' => 'link'
                        'link' => 'select-tarot'
                    ]}
                </div>
            </div>
        </div>
    </div>
</div>