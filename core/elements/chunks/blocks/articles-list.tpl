{set $objs = '!pdoPage' | snippet : [
    'parents' => $idParent
    'sortby' => 'publishedon'
    'sortdir' => 'DESC'
    'includeTVs' => $includeTVs
    'includeContent' => '1'
    'tplPageFirstEmpty' => ''
    'tplPageLastEmpty' => ''
    'tplPageFirst' => ''
    'tplPageLast' => ''
    'tplPage' => '@INLINE <li><a href="{$href}">{$pageNo < 10 ? "0" ~ $pageNo : $pageNo}</a></li>'
    'tplPageActive' => '@INLINE <li class="active"><a href="{$href}">{$pageNo < 10 ? "0" ~ $pageNo : $pageNo}</a></li>'
    'tplPagePrevEmpty' => '@INLINE <li class="disabled"><span>
                                        <svg width="15" height="13" viewBox="0 0 15 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M5 1L1 6.5M5 12L1 6.5M1 6.5H15" stroke="#8F97B8"/>
                                        </svg>
                                    </span></li>'
    'tplPagePrev' => '@INLINE   <li class="control"><a href="{$href}">
                                    <svg width="15" height="13" viewBox="0 0 15 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M5 1L1 6.5M5 12L1 6.5M1 6.5H15" stroke="#8F97B8"/>
                                    </svg>            
                                </a></li>'
    'tplPageNextEmpty' => '@INLINE  <li class="disabled"><span>
                                        <svg width="15" height="13" viewBox="0 0 15 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                            <path d="M10 1L14 6.5M10 12L14 6.5M14 6.5H0" stroke="#8F97B8"/>
                                        </svg>            
                                    </span></li>'
    'tplPageNext' => '@INLINE   <li class="control"><a href="{$href}">
                                    <svg width="15" height="13" viewBox="0 0 15 13" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M10 1L14 6.5M10 12L14 6.5M14 6.5H0" stroke="#8F97B8"/>
                                    </svg>      
                                </a></li>'
    'return' => 'json'
    'limit' => $limit == '' ? 12 : $limit
] | json_decode : true}

<div class="articles-list">
    <div class="articles-list-container container">
        <div class="articles-list__content articles-list-content">
            <div class="articles-list-content__body">
                <div class="articles-list-content__tags">
                    <div class="articles-list-content__tags--list">
                        <div class="articles-list-content__tags--title">
                            Теги:
                        </div>
                        {$tags = '@FILE snippets/findTVsValues.php' | snippet : [
                            'tvid' => 3
                        ]}
                    </div>
                </div>
                <div class="articles-list-content__list">
                    {foreach $objs as $item}
                        {'@FILE chunks/elements/article-element.tpl' | chunk : [
                            'pagetitle' => $item.pagetitle
                            'content' => $item.content | truncate: 200 | strip_tags
                            'publishedon' => $item.publishedon | date: 'd.m.Y'
                            'preview' => $item['tv.preview']
                            'uri' => $item.uri
                            'views' => $item['tv.views']
                            'itemArray' => $item
                        ]}
                    {/foreach}
                </div>

                {'page.nav' | placeholder}
            </div>
        </div>
    </div>
</div>