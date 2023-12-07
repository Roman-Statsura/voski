{extends 'file:templates/base.tpl'}

{set $swiperBundleJS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/js/swiper-bundle.min.js'
]}

{set $swiperBundleCSS = '@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/css/swiper-bundle.min.css'
]}

{set $swiperBundleJSPreload = '<link rel="preload" as="script" href="'~$swiperBundleJS~'">'}
{set $swiperBundle = '<link href="'~$swiperBundleCSS~'" rel="stylesheet">'}
{set $swiperBundlePreload = '<link rel="preload" as="style" href="'~$swiperBundleCSS~'">'}

{$swiperBundlePreload | htmlToHead: true}
{$swiperBundleJSPreload | htmlToHead: true}
{$swiperBundle | htmlToHead: true}

{block 'body'}
    {'@FILE chunks/elements/breadcrumbs.tpl' | chunk : [
        'classes' => 'background_snow-white'
    ]}
    {'@FILE chunks/blocks/just-block.tpl' | chunk : [
        'title' => 'Частная практика без офиса и накладных расходов.'
        'block' => '<p>Частная практика без офиса и накладных расходов.</p>
                    <p>Присоединяйтесь к профессионалам на онлайн-платформе консультирования.</p>
                    <p class="font-weight--300">
                        Мы обеспечиваем рекламу, удобный онлайн сервис и дополнительный доход. Вы 
                        обеспечиваете профессионализм, готовность делиться опытом, использовать 
                        необходимые навыки, желание помогать людям.
                    </p>'
        'direction' => 'column'
        'backgroundTheme' => 'tarologist background_snow-white'
        'tiny' => 'true'
    ]}
{/block} 

{block 'content'}
    {'@FILE chunks/blocks/page-detailed.tpl' | chunk : [
        "wawe" => 1,
        "theme" => "white",
        "onlytop" => "wawe-container--onlytop",
        "title" => "Почему именно ОРАКУЛ?",
        "sidebarImage" => "/assets/img/blocks/tarologist-image.png",
        "content" => "
            <ul>
                <li><span>У нас дружный коллектив и взаимопомощь</span></li>
                <li><span>
                    Бесплатные вебинары по привлечению клиентов к платным консультациям. Такая 
                    возможность у Вас появится после 2-3 месяцев консультирования на проекте.
                </span></li>
                <li><span>
                    У нас - полноценные консультации. Каждая консультация закрепляется за 
                    конкретным специалистом. Общаться в консультации могут только клиент, 
                    создавший консультацию, и закрепленный Астролог. Другие клиенты не имеют 
                    возможности вступать в дискуссию.
                </span></li>
                <li><span>
                    Полноценный профиль Астролога (минисайт), в котором собрана полная информация 
                    о специалисте (проведенные консультации, размещенные статьи, отзывы клиентов, 
                    дипломы об образовании и сертификаты, стоимость консультаций и др.). Ваши 
                    профили -  это качественная реклама Вашей деятельности. При выборе специалиста 
                    клиенты ориентируются на содержание вашего профиля.
                </span></li>
                <li><span>
                    ОРАКУЛ может быть как единственным источником дохода («полный рабочий день»), 
                    так и дополнением к Вашей основной работе. Вы сами выбираете клиентов, 
                    соответствующих Вашему профилю, а также определяете- с каким количеством 
                    клиентов Вы готовы работать.
                </span></li>
                <li><span>
                    Вы сами формируете своё расписание с учетом удобного для Вас времени. 
                    Это может быть как утро, день, вечер, так и целый день.
                </span></li>
                <li><span>
                    Вам не нужно беспокоиться о поиске клиентов, выставлении счетов и других 
                    операциях. Мы - рядом и поможем справиться с этим!
                </span></li>
            </ul>
        "
    ]}

    {'@FILE chunks/blocks/block-list.tpl' | chunk : [
        'blockTitle' 
        'elements' => [[
            "icon" => "@FILE chunks/icons/icon-tarologist-4.tpl",
            "iconType" => "svgElem",
            "title" => "Наличие сертификата."
        ], [
            "icon" => "@FILE chunks/icons/icon-tarologist-5.tpl",
            "iconType" => "svgElem",
            "title" => "Надежное подключение к интернету"
        ], [
            "icon" => "@FILE chunks/icons/icon-tarologist-6.tpl",
            "iconType" => "svgElem",
            "title" => "Полноценные и логически завершенные консультации"
        ], [
            "icon" => "@FILE chunks/icons/icon-tarologist-7.tpl",
            "iconType" => "svgElem",
            "title" => "Отличные навыки письма"
        ]]
        'wawe' => false
        'theme' => 'white'
        'onlytop' => 'wawe-container--onlytop'
    ]}

    
    {'@FILE chunks/blocks/block-list.tpl' | chunk : [
        'blockTitle' => "Как получить статус Астролога ОРАКУЛ?"
        'columns' => "3",
        'footerButton' => 'true'
        'elements' => [[
            "icon" => "/assets/img/blocks/tarologist-0.png",
            "title" => "1. Прочитайте требования",
            "desc" => "
                Внимательно прочитайте и примите <a href='#' class='link--theme--mint'>наши правила</a>
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-1.png",
            "title" => "2. Пройдите регистрацию",
            "desc" => "
                Зарегистрируйтесь на сайте. При регистрации укажите настоящие имя и фамилию.
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-2.png",
            "title" => "3. Загрузите дипломы",
            "desc" => "
                Пройдя регистрацию в личном кабинете, необходимо загрузить дипломы и сертификаты.
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-4.png",
            "title" => "4. Дождитесь проверки",
            "desc" => "
                Ваш профиль проверят администраторы и активируют его. Как правило, это занимает не более 4 рабочих дней.
            "
        ], [
            "icon" => "/assets/img/blocks/tarologist-5.png",
            "title" => "5. Получите доступ",
            "desc" => "
                После того как Вы получите подтверждение статуса Астролога ОРАКУЛ, Вам станут доступны все возможности нашего сервиса.
            "
        ], [
            "title" => "Будем рады видеть Вас в нашей команде !",
            "specialTitle" => true
        ]]
    ]}        
{/block} 