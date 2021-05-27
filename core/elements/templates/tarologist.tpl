{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk : [
        'classes' => 'background_snow-white'
    ]}
    {'@FILE chunks/blocks/just-block.tpl' | chunk : [
        'title' => 'Частная практика без офиса и накладных расходов.'
        'block' => '<p>Присоединяйтесь к профессионалам на онлайн-платформе консультирования.</p>
                    <p>
                        Et, orci venenatis nibh tempor sodales egestas sed molestie. Tellus 
                        gravida felis risus purus diam aenean ut sem. Auctor venenatis in nunc nulla. Massa, 
                        nunc libero egestas lacus, vel. Eleifend amet, nunc porta convallis tincidunt 
                        ut tortor, urna.
                    </p>
                    <p>
                        Et, orci venenatis nibh tempor sodales egestas sed molestie. Tellus gravida felis 
                        risus purus diam aenean ut sem. Auctor venenatis in nunc nulla. Massa, nunc 
                        libero egestas lacus, vel.
                    </p>'
        'direction' => 'column'
        'backgroundTheme' => 'tarologist background_snow-white'
        'tiny' => 'true'
    ]}
{/block} 

{block 'content'}
    {'@FILE chunks/blocks/block-list.tpl' | chunk : [
        'elements' => [[
            "icon" => "@FILE chunks/icons/icon-tarologist-1.tpl",
            "iconType" => "svgElem",
            "title" => "Приводим клиентов,<br>готовых к работе",
            "desc" => "
                Мы рекламируем сервис, пишем  статьи со ссылками на Voski, проводим лекции и ведем 
                социальные сети. Так у сервиса становится больше подготовленных к терапии клиентов, 
                а значит — и у вас.
            "
        ], [
            "icon" => "@FILE chunks/icons/icon-tarologist-2.tpl",
            "iconType" => "svgElem",
            "title" => "Уведомляем об изменениях<br>в расписании",
            "desc" => "
                Клиенты выбирают доступный слот для записи в календаре таролога и подтверждают 
                запись, а психолог получает уведомление о новой записи, переносах и отменах 
                записей по email и СМС.
            "
        ], [
            "icon" => "@FILE chunks/icons/icon-tarologist-3.tpl",
            "iconType" => "svgElem",
            "title" => "Гарантируем<br>оплату сессии",
            "desc" => "
                Клиенты оплачивают сессии по банковской карте из России и из-за рубежа, деньги 
                списываются за 24 часа до начала сессии, даже если клиент отменяет в последний момент.
            "
        ]]
        'wawe' => 'true'
        'theme' => 'white'
        'onlytop' => 'wawe-container--onlytop'
    ]}

    
    {'@FILE chunks/blocks/block-list.tpl' | chunk : [
        'blockTitle' => "Присоединяйтесь к нам!"
        'footerButton' => 'true'
        'elements' => [[
            "icon" => "/assets/img/blocks/tarologist-0.png",
            "title" => "1. Прочитайте требования",
            "desc" => "
                Внимательно прочитайте <a href='#' class='link--theme--mint'>требования для тарологов</a>, перед тем как заполнять заявку
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-1.png",
            "title" => "2. Пройдите тест",
            "desc" => "
                Пройдите предложенный нами тест  на профессиональную компетентность. Это займет около 10 минут. 
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-2.png",
            "title" => "3. Отправить скан/фото дипломов",
            "desc" => "
                Отправьте имеющиеся у вас дипломы и сертификаты подитверждающие вашу компетенцию
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-3.png",
            "title" => "4. Ждите звонка!",
            "desc" => "
                После подачи заявки мы обязательно свяжемся с Вами для обсуждения дальнейшего сотрудничества!
            "
        ]]
    ]}
{/block} 
