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
                                'text' => 'Мы предоставляем персонализированный подбор астрологов'
                            ]}
                            {'@FILE chunks/elements/card-icons.tpl' | chunk : [
                                'icon' => '@FILE chunks/icons/icon-edu.tpl'
                                'text' => 'Наши астрологи - прошедшие курсы и подтвердившие квалификацию'
                            ]}
                            {'@FILE chunks/elements/card-icons.tpl' | chunk : [
                                'icon' => '@FILE chunks/icons/icon-offer-sec.tpl'
                                'text' => 'Гарантия возврата денег при возникновении конфликтных ситуаций'
                            ]}
                        </div>
                        <div class="guarantees-swiper__pagination swiper-pagination guarantees-swiper__pagination--disabled"></div>
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
            clickable: true
        },
        breakpoints: {
            0: {
                slidesPerView: 1,
                allowTouchMove: true
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

    if (window.innerWidth > 992) {
        if (document.querySelectorAll(".guarantees-swiper__container .swiper-slide").length > 3) {
            document.querySelector.classList.remove("disabled");
        }
    }

    function hidePagination() {
        let slides      = document.querySelectorAll(".guarantees-swiper__container .swiper-slide"),
            pagination  = document.querySelector(".guarantees-swiper__pagination");
        
        if (window.innerWidth > 992) {
            if (slides.length > 3) {
                pagination.classList.remove("guarantees-swiper__pagination--disabled");
            } else {
                pagination.classList.add("guarantees-swiper__pagination--disabled");
            }
        } else {
            pagination.classList.remove("guarantees-swiper__pagination--disabled");
        }
    }

    hidePagination();

    window.addEventListener("resize", function(event) {
        hidePagination();
    });

</script>',true)}