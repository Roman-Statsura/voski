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

{set $imageField = '/assets/img/blocks/why.png'}
{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => 'w=372&h=280&zc=C&q=100'
]}
{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $imageField,
    'options' => 'w=372&h=280&zc=C&q=100&f=webp'
]}

<div class="why wawe-container wawe-container-theme--white">
    <div class="why-container container">
        <div class="why-container__content why-content">
            <div class="why-content__block why-content__first">
                <h2 class="why-content__block--title">Почему мы?</h2>
                <div class="why-content__block--text">
                    <p>
                        В России отсутствует лицензирование Тарологов: никто не проверяет образование, качество работы и 
                        адекватность методик практикующих специалистов. VOSKI решает эту проблему.<br>
                        Все наши Тарологи прошли отбор по методике, разработанной  старейшими школами Таро в России. 
                        Только 40% специалистов проходят отбор. 
                    </p>
                </div>
            </div>
            <div class="why-content__block">
                <picture>
                    <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                    <img class="main-header-content__block_image" src="{$thumbFromPhoto}" alt="" />
                </picture>
            </div>
        </div>

        <div class="why-container__content why-content">
            <div class="why-content__block">
                <h3 class="why-content__block--title_h3">Мы проверяем:</h3>
                <div class="why-content__block--items">
                    <div class="why-content-swiper__container swiper-container">
                        <div class="swiper-wrapper why-content-swiper__wrapper">
                            {'@FILE chunks/elements/card.tpl' | chunk : [
                                'slider' => 1
                                'text' => 'Успешные кейсы по заявленным специализациям'
                            ]}
                            {'@FILE chunks/elements/card.tpl' | chunk : [
                                'slider' => 1
                                'text' => 'Уровень базовых и профессиональных знаний'
                            ]}
                            {'@FILE chunks/elements/card.tpl' | chunk : [
                                'slider' => 1
                                'text' => 'Опыт работы в заданной сфере'
                            ]}
                            {'@FILE chunks/elements/card.tpl' | chunk : [
                                'slider' => 1
                                'text' => 'Адекватность и этические принципы.'
                            ]}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{$_modx->regClientScript('@FILE snippets/fileVersion.php' | snippet : [
    'input' => 'assets/js/swiper-bundle.min.js'
])}
{$_modx->regClientScript('<script>
    var galleryThumbs = new Swiper(".why-content-swiper__container", {
        spaceBetween: 24,
        slidesPerView: 4,
        breakpoints: {
            0: {
                slidesPerView: 1
            },
            768: {
                slidesPerView: 3
            },
            992: {
                slidesPerView: 4
            }
        }
    });
</script>',true)}