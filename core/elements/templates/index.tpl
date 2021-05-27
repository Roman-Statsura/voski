{extends 'file:templates/base.tpl'}

{block 'body'}
    {'@FILE chunks/blocks/main-header.tpl' | chunk}
    {'@FILE chunks/blocks/why.tpl' | chunk}
    {'@FILE chunks/blocks/guarantees.tpl' | chunk}
    {'@FILE chunks/blocks/tarolog.tpl' | chunk}
    {'@FILE chunks/blocks/service.tpl' | chunk}
    
    {set $quote = '@FILE chunks/elements/quote.tpl' | chunk : [
        'text' => '
            <p>
                Карты Таро были созданы в те времена , когда таинственному и иррациональному принадлежало 
                больше реальности, чем у них имеется сегодня, поэтому они служат для нас эффективным мостом 
                к унаследованной мудрости предков в нашей глубочайшей и сокровеннейшей самости. И 
                новая мудрость является огромной необходимостью нашего времени &ndash; мудрость разрешить 
                наши собственные личные проблемы и мудрость, чтобы найти творческие, креативные ответы на 
                универсальные вопросы, с которыми сталкивается каждый из нас.<br /><br />Таро имеет в своих 
                истоках глубинные паттерны коллективного бессознательного с доступом к возможностям увеличения 
                сознания во время соприкосновения с гадательными Практиками Таро. В этом его особая важность.
            </p>
        '
        'name' => 'Фразы К.Г. Юнга'
    ]}

    {'@FILE chunks/blocks/just-block.tpl' | chunk : [
        'block' => $quote
    ]} 

    {'@FILE chunks/blocks/helped-slider.tpl' | chunk}
    {'@FILE chunks/blocks/socials.tpl' | chunk}
{/block}