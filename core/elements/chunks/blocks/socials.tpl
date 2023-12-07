<div class="socials">
    <div class="socials-container container">
        <div class="socials-container__content socials-content">
            <div class="socials-content__header">
                <h2 class="socials-content__header--title">
                    Если у вас остались вопросы, напишите нам!
                </h2>
            </div>
            <div class="socials-content__body">
                <div class="socials-content__items">
                    {'@FILE chunks/elements/social.tpl' | chunk : [
                        'icon' => '@FILE chunks/icons/icon-telegram.tpl'
                        'title' => 'Telegram'
                    ]}
                    {'@FILE chunks/elements/social.tpl' | chunk : [
                        'icon' => '@FILE chunks/icons/icon-whatsapp.tpl'
                        'title' => 'Whatsapp'
                    ]}
                </div>
            </div>
        </div>
    </div>
</div>