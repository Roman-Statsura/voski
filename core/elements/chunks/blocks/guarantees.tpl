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

<div class="guarantees wawe-container wawe-container-theme--gray">
    <div class="guarantees-container container">
        <div class="guarantees-container__content guarantees-content">
            <div class="guarantees-content__header">
                <h2 class="guarantees-content__header--title">Наши гарантии</h2>
            </div>
            <div class="guarantees-content__body">
                <div class="guarantees-content__block">
                    <div class="guarantees-swiper__container swiper-container">
                        <div class="swiper-wrapper guarantees-swiper__wrapper">
                            {'@FILE chunks/elements/card-icons.tpl' | chunk : [
                                'icon' => '@FILE chunks/icons/icon-offer.tpl'
                                'text' => 'Мы предоставляем персонализированный подбор тарологов'
                            ]}
                            {'@FILE chunks/elements/card-icons.tpl' | chunk : [
                                'icon' => '@FILE chunks/icons/icon-edu.tpl'
                                'text' => 'Наши тарологи - прошедшие курсы и подтвердившие квалификацию'
                            ]}
                            {'@FILE chunks/elements/card-icons.tpl' | chunk : [
                                'icon' => '@FILE chunks/icons/icon-offer-sec.tpl'
                                'text' => 'Гарантия возврата денег при возникновении конфликтных ситуаций'
                            ]}
                        </div>
                        <div class="guarantees-swiper__pagination swiper-pagination"></div>
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
    var galleryThumbs = new Swiper(".guarantees-swiper__container", {
        spaceBetween: 15,
        slidesPerView: 1,
        allowTouchMove: false,
        pagination: {
            el: ".swiper-pagination",
            type: "bullets",
        },
        breakpoints: {
            0: {
                slidesPerView: 1
            },
            768: {
                slidesPerView: 2,
                allowTouchMove: true
            },
            992: {
                slidesPerView: 3,
                allowTouchMove: false
            }
        }
    });
</script>',true)}