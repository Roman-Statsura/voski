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

<div class="helped-slider">
    <div class="helped-slider-container container">
        <div class="helped-slider-container__content helped-slider-content">
            <div class="helped-slider-content__header">
                <h2 class="helped-slider-content__header--title">
                    <span>Мы уже помогли 564 нашим клиентам,</span>
                    и вот что они говорят о нас
                </h2>
            </div>
            <div class="helped-slider-content__body helped-slider-swiper">
                <div class="swiper-container helped-slider__wrapper slider-thumbs">
                    <div class="swiper-wrapper slider-thumbs__wrapper">
                        {'@FILE chunks/elements/slider-images.tpl' | chunk : [
                            'image' => '/assets/img/blocks/review_1.png'
                        ]}
                        {'@FILE chunks/elements/slider-images.tpl' | chunk : [
                            'image' => '/assets/img/blocks/review_1.png'
                        ]}
                    </div>
                </div>

                <div class="helped-slider-swiper__container swiper-container">
                    <div class="swiper-wrapper helped-slider-swiper__wrapper">
                        {'@FILE chunks/elements/slider-item.tpl' | chunk : [
                            'image' => '/assets/img/blocks/review_1.png'
                            'text' => '
                                Я благодарю данный сервис за удобство и возможность получить профессиональную консультацию. Когда я общалась с Тарологом, мне помогли неожиданно, эффективно понять, что происходит в моей ситуации. И что с этим делать. Обращусь ещё.
                                Спасибо вашей программе 🌹🌹🌹
                            '
                            'name' => 'Милошникова Дарья'
                        ]}
                        {'@FILE chunks/elements/slider-item.tpl' | chunk : [
                            'image' => '/assets/img/blocks/review_1.png'
                            'text' => '
                                Я благодарю данный сервис за удобство и возможность получить профессиональную консультацию. Когда я общалась с Тарологом, мне помогли неожиданно, эффективно понять, что происходит в моей ситуации. И что с этим делать. Обращусь ещё.
                                Спасибо вашей программе 🌹🌹🌹
                            '
                            'name' => 'Милошникова Дарья'
                        ]}
                    </div>
                    <div class="helped-slider-content__buttons">
                        <div class="helped-slider-content__buttons--prev">
                            <svg width="76" height="17" viewBox="0 0 76 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M75 8.25342H1" stroke="#4DDBDB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M8 14.5868L1 7.92009L8 1.25342" stroke="#4DDBDB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>                            
                        </div>
                        <div class="helped-slider-content__buttons--next">
                            <svg width="76" height="17" viewBox="0 0 76 17" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M1 8.25341L75 8.25342" stroke="#4DDBDB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M68 1.92008L75 8.58675L68 15.2534" stroke="#4DDBDB" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>                            
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
    var galleryThumbs = new Swiper(".slider-thumbs", {
        spaceBetween: 12,
        slidesPerView: 5,
        allowTouchMove: false,
        preloadImages: false,
        lazy: true,
        watchSlidesVisibility: true,
        watchSlidesProgress: true,
    });

    var galleryTop = new Swiper(".helped-slider-swiper__container", {
        spaceBetween: 15,
        slidesPerView: 1,
        navigation: {
            nextEl: ".helped-slider-content__buttons--next",
            prevEl: ".helped-slider-content__buttons--prev",
        },
        breakpoints: {
            0: {
                slidesPerView: 1
            },
        },
        thumbs: {
            swiper: galleryThumbs
        }
    });
</script>',true)}