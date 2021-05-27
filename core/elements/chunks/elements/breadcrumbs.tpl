<div class="breadcrumbs {$classes}">
    <div class="container breadcrumbs__container">
        <div class="breadcrumbs__block">
            {'!pdoCrumbs' | snippet : [
                'showHome' => 1
                'outputSeparator' => '<li>/</li>'
                'tplCurrent' => '@INLINE <li class="active">
                    <span>{$menutitle}</span>
                </li>'
            ]}
        </div>
    </div>
</div>