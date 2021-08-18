{set $tarotScheduleNew = '!scheduleNew' | snippet : [
    'idTarot'  => $.post.idTarot
] | json_encode : true}

{set $tarotScheduleNewArr = $tarotScheduleNew | json_decode : true}

<div class="schedule-block__date">
    {if count($tarotScheduleNewArr) > 0}
        {foreach $tarotScheduleNewArr as $schDate => $tarotScheduleItem}
            <div class="schedule-block__content">
                <div class="schedule-block__date--title">
                    {$schDate | strtotime | rusDate}
                </div>
                <div class="schedule-block__date--list swiper-container swiper-schedule--{$schDate | date: 'dmY'}">
                    <div class="swiper-wrapper">
                        {foreach $tarotScheduleItem as $schItem}
                            {set $newDateTime = $schDate ~ $schItem}
                            <div class="schedule-block__item swiper-slide">
                                <input id="time-{$newDateTime | date: 'dmYHi'}" class="schedule-block__item--radio" type="radio" name="schTime" value="{$schDate} {$schItem}">
                                <label for="time-{$newDateTime | date: 'dmYHi'}" class="schedule-block__item--label">
                                    {$schItem}
                                </label>
                            </div>
                        {/foreach}
                    </div>
                    <div class="swiper-scrollbar"></div>
                </div>
            </div>
        {/foreach}
    {else}
        У специалиста, еще не указано расписание для записи. Вернитесь в другое время
    {/if}
</div>