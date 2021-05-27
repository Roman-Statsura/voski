<div class="service wawe-container wawe-container-theme--white">
    <div class="service-container container">
        <div class="service-container__content service-content">
            <div class="service-content__header">
                <h2 class="service-content__header--title">Сервис устроен легко и удобно</h2>
            </div>
            <div class="service-content__body">
                <div class="service-content__block">
                    {'@FILE chunks/elements/block-chess.tpl' | chunk : [
                        'image' => '/assets/img/blocks/img_videochat.png'
                        'title' => 'Защищённый видеочат'
                        'desc' => '
                            На нашей платформе видеоконсультации проходят в защищенном личном кабинете. 
                            Конфиденциальные сессии с вашим таргологом доступны из любой точки мира.
                        '
                    ]}
                    {'@FILE chunks/elements/block-chess.tpl' | chunk : [
                        'image' => '/assets/img/blocks/img_session.png'
                        'title' => 'Простое расписание'
                        'desc' => '
                            Назначайте и переносите, если ваши планы изменились. 
                            А мы всегда напомним вам о начале сеанса.
                        '
                    ]}
                    {'@FILE chunks/elements/block-chess.tpl' | chunk : [
                        'image' => '/assets/img/blocks/img_chat.png'
                        'title' => 'Сопровождение на всех этапах'
                        'desc' => '
                            Ответим на вопросы о сервисе или таргологии, поможем, поддержим, объясним, направим.
                        '
                    ]}
                </div>
            </div>
        </div>
    </div>
</div>