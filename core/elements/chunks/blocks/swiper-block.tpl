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

<div class="why wawe-container wawe-container-theme--white">
    <div class="why-container container">
        <div class="why-container__content why-content">
            <div class="why-content__block">
                <h2 class="why-content__block--title">{$title}</h2>
                <div class="why-content__block--items">
                    <div class="why-content-swiper__container swiper-container">
                        <div class="swiper-wrapper why-content-swiper__wrapper">
                            {foreach $list as $item}
                                {'@FILE chunks/elements/card.tpl' | chunk : [
                                    'slider' => 1
                                    'text' => $item.text
                                ]}
                            {/foreach}
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
        slidesPerView: 2,
        breakpoints: {
            0: {
                slidesPerView: 1
            },
            768: {
                slidesPerView: 3
            },
            992: {
                slidesPerView: 2
            }
        }
    });
</script>',true)}