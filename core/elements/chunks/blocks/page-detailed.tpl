{set $thumbFromPhoto = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $sidebarImage,
    'options' => 'w=285&zc=C&q=85'
]}
{set $thumbFromPhotoWebP = '@FILE snippets/pThumb/pthumb.php' | snippet : [
    'input' => $sidebarImage,
    'options' => 'w=285&zc=C&q=85&f=webp'
]}

<div class="page-detailed">
    <div class="page-detailed-container container">
        <div class="page-detailed-container__content page-detailed-content">
            <div class="page-detailed-content__body">
                <div class="page-detailed-content__body--sidebar page-detailed-content-sidebar">
                    <div class="page-detailed-content-sidebar__title">
                        {$title}
                    </div>
                    {if $desc != ""}
                        <div class="page-detailed-content-sidebar__desc">
                            {$desc}
                        </div>
                    {/if}
                    <div class="page-detailed-content-sidebar__picture">
                        <picture>
                            <source srcset="{$thumbFromPhotoWebP}" type="image/webp">
                            <img class="page-detailed-content-sidebar__image" src="{$thumbFromPhoto}" alt="" />
                        </picture>

                        {if $hasButton}
                            <div class="page-detailed-content-sidebar__button">
                                {'@FILE chunks/elements/button.tpl' | chunk : [
                                    'buttonTitle' => $buttonTitle
                                ]}
                            </div>
                        {/if}
                    </div>
                </div>
                <div class="page-detailed-content__body--section page-detailed-content-section">
                    {$content}
                </div>
            </div>
        </div>
    </div>
</div>