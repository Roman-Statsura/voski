let options = {
    intervalDay: 0,
    removeClientRecord: 0
};

function createCalendar(elem, month, year, userData = {}, diff = 2) {
    let mon = month,
        d = new Date(year, mon),
        dNext = new Date(year, mon+1),
        day = d.getDate(),
        curDate = new Date(),
        curDay = curDate.getDate(),
        curMonth = curDate.getMonth(),
        curYear = curDate.getFullYear(),
        divClass = "",
        schRecord = {};

    let divTable = `
        <div class="calendar-table">
            <div class="preloader">
                <svg class="preloader__image" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                    <path fill="currentColor"
                        d="M304 48c0 26.51-21.49 48-48 48s-48-21.49-48-48 21.49-48 48-48 48 21.49 48 48zm-48 368c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zm208-208c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.49-48-48-48zM96 256c0-26.51-21.49-48-48-48S0 229.49 0 256s21.49 48 48 48 48-21.49 48-48zm12.922 99.078c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.491-48-48-48zm294.156 0c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48c0-26.509-21.49-48-48-48zM108.922 60.922c-26.51 0-48 21.49-48 48s21.49 48 48 48 48-21.49 48-48-21.491-48-48-48z">
                    </path>
                </svg>
            </div>
            <div class="calendar-table--row calendar-table--head">
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Пн</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Вт</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Ср</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Чт</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Пт</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Сб</div>
                </div>
                <div class="calendar-table--col">
                    <div class="calendar-table--col--content">Вс</div>
                </div>
            </div>
            <div class="calendar-table--row calendar-table--body">
    `;

    for (let i = 0; i < getDay(d); i++) {
        divTable += `<div class="calendar-table--col empty">
            <div class="calendar-table--col--content"></div>
        </div>`;
    }

    while (d.getMonth() == mon) {
        var date = d.getDate();
        var monthNormal = d.getMonth();

        monthNormal += 1;
        if (monthNormal < 10) {
            monthNormal = "0" + monthNormal;
        }

        if (date == curDay && mon == curMonth && year == curYear) {
            divClass = "current";
        } else if ((date < curDay && mon == curMonth) || (mon < curMonth) && year <= curYear) {
            divClass = "outdate";
        }  else {
            divClass = "";
        }

        if (date < 10) {
            date = "0" + date;
        }

        divTable += `<div class="calendar-table--col ${divClass}" 
                        ${divClass !== 'current' ? `
                            data-action="addEvent" 
                        `: '' }
                        data-calendarday="${divClass}"
                        data-day="${getDayName(getDay(d))}" 
                        data-date="${year}-${monthNormal}-${date}" 
                        data-readdate="${date} ${getMonthName(mon)}">
                        <div class="calendar-table--col--content">
                            <div class="calendar-table--col-days">
                                <span class="calendar-table--col-day">${getDayName(getDay(d))}</span>
                                <span>${date}</span>
                            </div>
                            <div class="calendar-table--records" data-recordDate="${year}-${monthNormal}-${date}"></div>
                        </div>
                    </div>`;

        if (getDay(d) % 7 == 6) {
            divTable += '</div><div class="calendar-table--row calendar-table--body">';
        }

        d.setDate(d.getDate() + 1);

        schRecord[`${year}-${monthNormal}-${date}`] = {};
    }

    if (getDay(d) != 0) {
        for (let i = getDay(d); i < 7; i++) {
            divTable += `<div class="calendar-table--col empty">
                <div class="calendar-table--col--content"></div>
            </div>`;
        }
    }

    divTable += '</div></div><div class="calendar-modal--overlay"></div>';
    elem.innerHTML = divTable;
    
    if (userData.schedule) {
        userData.schedule.forEach(el => {
            let newDateTime = new Date(el.datetime),
                newDateEndTime = new Date(el.datetimeEnd),
                newDateYear = newDateTime.getFullYear(),
                newDateMonth = newDateTime.getMonth() + 1,
                newDateDay = newDateTime.getDate(),
                newTime = `${newDateTime.getHours()}:${newDateTime.getMinutes() < 10 ? '0' + newDateTime.getMinutes() : newDateTime.getMinutes()}`,
                newTimeEnd = `${newDateEndTime.getHours()}:${newDateEndTime.getMinutes() < 10 ? '0' + newDateEndTime.getMinutes() : newDateEndTime.getMinutes()}`;

            if (newDateMonth < 10) {
                newDateMonth = "0" + newDateMonth;
            }
            
            if (newDateDay < 10) {
                newDateDay = "0" + newDateDay;
            }

            if (schRecord[`${newDateYear}-${newDateMonth}-${newDateDay}`] !== undefined) {
                if (schRecord[`${newDateYear}-${newDateMonth}-${newDateDay}`][`${newTime}`] === undefined) {
                    if (el.username != "" && el.username != null) {
                        state = el.username;
                    } else if (el.status == 2) {
                        state = "Занят";
                    } else {
                        state = "Свободно";
                    }

                    schRecord[`${newDateYear}-${newDateMonth}-${newDateDay}`][`${newTime}`] = `
                        <button class="calendar-table--record ${el.status == 2 ? 'calendar-table--record--busy' : ''}"
                            data-action="editEvent" 
                            data-migxid="${el.MIGX_id}"
                            data-day="${getDayName(getDay(newDateTime))}" 
                            data-date="${year}-${newDateMonth}-${newDateDay}" 
                            data-readdate="${newDateDay} ${getMonthName(newDateTime.getMonth())}"
                            data-time="${newTime}"
                            ${el.username !== undefined ? `
                                data-client="${el.username}"
                                data-gender="${el.gender}"
                                data-age="${el.age}"
                                data-zoom="${el.zoomLink}"
                            `: '' }
                            ${options.intervalDay ? `
                                data-timeend="${newTimeEnd}"
                                data-allday="${el.allDay}"
                            `: '' }
                            data-status="${el.status}"
                            data-desc="${el.desc}">
                            <span>${newTime}</span>
                            <span class="calendar-state" data-text="${year}-${newDateMonth}-${newDateDay}-${newTime}-state">
                                ${state}
                            </span>
                        </button>
                    `;
                }
            }
        });
    }

    Object.keys(schRecord).map(function(objectKey) {
        let moreButton = "";
        Object.keys(schRecord[objectKey]).sort().forEach(function(objKey, index) {
            let leftQueries = Object.keys(schRecord[objectKey]).length - diff;
            if (index < diff) {
                document.querySelector(`[data-recorddate="${objectKey}"]`).innerHTML += schRecord[objectKey][objKey];
            } else {
                moreButton = `<a href="#" class="calendar-table--more" data-action="showmore" data-date="${objectKey}">Ещё ${leftQueries}</a>`;
            }
        });
        document.querySelector(`[data-recorddate="${objectKey}"]`).innerHTML += moreButton;
    });

    showMoreObjects(elem);
    generateForm(elem, userData, options);
    generateUserRecord(elem, userData, options);

    let eventButton = document.querySelectorAll('.calendar-table [data-action]'),
        eventModals = document.querySelectorAll('.calendar-modal[data-modalid]');

    eventButton.forEach(el => {
        if (!el.classList.contains("outdate")) {
            el.addEventListener("click", function(e) {
                e.stopPropagation();
                e.preventDefault();

                eventModals.forEach(element => {
                    element.classList.remove('show');
                });

                if (this.dataset.action === "showmore") {
                    setMoreModalPosition(this, findInNodeList(eventModals, this.dataset.action), schRecord[this.dataset.date], diff);
                } else {
                    if (el.dataset.client !== undefined) {
                        setModalClientPosition(this, findInNodeList(eventModals, "schClientEvent"), el.dataset) 
                    } else {
                        setModalPosition(this, findInNodeList(eventModals, "schEvent"), el.dataset);
                    }
                }
            });
        }
    });

    document.body.classList.add('loaded');
}

function hoursRange(lower = 0, upper = 86400, step = 3600) {
    let times = [];
    for (let i = lower; i < upper; i += step) {
        let hours = Math.floor(i / 60 / 60),
            minutes = Math.floor(i / 60) - (hours * 60),
            seconds = i % 60;

        let formatted = [
            hours.toString().padStart(2, '0'),
            minutes.toString().padStart(2, '0')
        ].join(':');

        times.push(formatted);
    }

    return times;
}

function optionTime(value = '') {
    let times = hoursRange(),
        options = [];

    times.forEach(element => {
        options.push(`<option value="${element}" ${element == value ? 'selected' : ''}>${element}</option>`);
    });

    return options;
}

function findInNodeList(nodeList, nodeRefToFind) {
    return Array.from(nodeList).find(node => node.dataset.modalid === nodeRefToFind);
}

function getDay(date) {
    let day = date.getDay();
    if (day == 0) day = 7;
    return day - 1;
}

function getMonth() {
    let month = date.getMonth();
    return month;
}

function setMoreModalPosition(evElem, modal, obj, diff = 2) {
    let posX = 0,
        posY = 0,
        newEvElem = evElem.parentElement.parentElement,
        modalBody = modal.children[1],
        getDateFromData = new Date(evElem.dataset.date),
        getMonthFromData = getDateFromData.getMonth(),
        getDayNumberFromData = getDateFromData.getDate();

    modalBody.innerHTML = "";

    document.querySelector('.calendar-modal [data-info="monthName"]').innerHTML = getMonthName(getMonthFromData);
    document.querySelector('.calendar-modal [data-info="dateName"]').innerHTML = getDayNumberFromData;

    Object.keys(obj).sort().forEach(function(objKey, index) {
        if (index >= diff) {
            modalBody.innerHTML += obj[objKey];
        }
    });

    let actionButtons = document.querySelectorAll('[data-modalid="showmore"] [data-action]'),
        eventModals = document.querySelectorAll('.calendar-modal[data-modalid]');
    
    actionButtons.forEach(el => {
        el.addEventListener("click", function(e) {
            e.stopPropagation();
            e.preventDefault();

            if (this.dataset.action === "editEvent") {
                setModalPosition(this, findInNodeList(eventModals, "schEvent"), el.dataset);
            }
        });
    });

    modal.classList.add("show");
    document.querySelector(".calendar-modal--overlay").classList.add("shown");

    posX = newEvElem.offsetParent.offsetLeft;
    posY = (newEvElem.offsetParent.offsetTop - (modal.offsetHeight - (newEvElem.offsetParent.offsetHeight + modal.offsetHeight)));
    
    if (window.innerWidth > 992) {
        modal.style.left = posX + "px";
        modal.style.top = posY + "px";
    } else {
        modal.style.left = "15px";
        modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
    }

    if (isHidden(modal)) {
        posX = newEvElem.offsetParent.offsetLeft - newEvElem.offsetParent.offsetWidth;
        posY = (newEvElem.offsetParent.offsetTop - (modal.offsetHeight - (newEvElem.offsetParent.offsetHeight + modal.offsetHeight)));

        if (window.innerWidth > 992) {
            modal.style.left = posX + "px";
            modal.style.top = posY + "px";
        } else {
            modal.style.left = "15px";
            modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
        }
    }
}

function showMoreObjects(elem) {
    let divQueriesObj = `
        <div class="calendar-modal calendar-modal--tiny" data-modalid="showmore">
            <div class="calendar-modal__header">
                <div class="calendar-modal__element">
                    <button class="calendar-modal__button" data-action="close">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M26 14L14 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M14 14L26 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </div>
                <div class="calendar-modal__element">
                    <span class="calendar-modal__span" data-info="monthName"></span>
                    <span class="calendar-modal__span" data-info="dateName"></span>
                </div>
            </div>
            <div class="calendar-modal__body"></div>
        </div>
    `;
    
    elem.innerHTML += divQueriesObj;

    let modal = document.querySelector('[data-modalid="showmore"]'),
        actionButtons = document.querySelectorAll('[data-modalid="showmore"] [data-action]');
    
    actionButtons.forEach(el => {
        el.addEventListener("click", function() {
            if (this.dataset.action === "close") {
                modal.classList.remove("show");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            }
        });
    });
}

function generateUserRecord(elem, userData) {
    let divForm = `
        <div class="calendar-modal" data-modalid="schClientEvent">
            <div class="calendar-modal__header">
                <div class="calendar-modal__element">
                    <button class="calendar-modal__button" data-action="close">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M26 14L14 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> 
                            <path d="M14 14L26 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </div>
                ${options.removeClientRecord ? `
                    <div class="calendar-modal__element">
                        <button class="calendar-modal__button" data-action="remove">
                            <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M11 14H13H29" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M16 14V12C16 11.4696 16.2107 10.9609 16.5858 10.5858C16.9609 10.2107 17.4696 10 18 10H22C22.5304 10 23.0391 10.2107 23.4142 10.5858C23.7893 10.9609 24 11.4696 24 12V14M27 14V28C27 28.5304 26.7893 29.0391 26.4142 29.4142C26.0391 29.7893 25.5304 30 25 30H15C14.4696 30 13.9609 29.7893 13.5858 29.4142C13.2107 29.0391 13 28.5304 13 28V14H27Z" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M18 19V25" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                <path d="M22 19V25" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </button>
                    </div>
                `: '' }
            </div>
            <div class="calendar-modal__body">
                <form id="schedule" method="POST">
                    <input type="hidden" name="migxID" value="">
                    <input type="hidden" name="profileID" value="${userData.id}">
                    <div class="calendar-modal__block calendar-modal__block--column">
                        <div class="calendar-modal__client" data-info="clientName"></div>
                    </div>
                    <div class="calendar-modal__block calendar-modal__block--column">
                        <div class="calendar-modal__group">
                            <span class="calendar-modal__span" data-info="dayNameClient"></span>
                            <label data-info="dateClient" for="dateClient" class="calendar-date__label">
                                <span></span>
                                <input id="dateClient" type="date" name="date" disabled>
                            </label>
                            <div class="calendar-date__times">
                                <span style="display: none;" data-info="timeClient"></span>
                                <label for="timeClient" class="calendar-date__label--time">
                                    <select id="timeClient" name="time" class="calendar-date__time" disabled>
                                        <option class="hidden-option" selected hidden disabled value="0">+ время</option>
                                        ${optionTime()}
                                    </select>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="calendar-modal__flex-block calendar-flex-block">
                        <div class="calendar-flex-block__icon">
                            <svg width="25" height="40" viewBox="0 0 25 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M22 18C22 25 13 31 13 31C13 31 4 25 4 18C4 15.6131 4.94821 13.3239 6.63604 11.636C8.32387 9.94821 10.6131 9 13 9C15.3869 9 17.6761 9.94821 19.364 11.636C21.0518 13.3239 22 15.6131 22 18Z" fill="#4DDBDB"/>
                                <path d="M13 21C14.6569 21 16 19.6569 16 18C16 16.3431 14.6569 15 13 15C11.3431 15 10 16.3431 10 18C10 19.6569 11.3431 21 13 21Z" fill="#FAFAFA" stroke="#FAFAFA" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            </svg>
                        </div>
                        <div class="calendar-flex-block__field">
                            <input class="form__input form__input--textarea" name="zoomLink" id="zoomLink" placeholder="Ссылка на Zoom">
                        </div>
                    </div>
                    <div class="calendar-modal__flex-block calendar-flex-block flex-direction--column align-item--flex-start">
                        <div class="calendar-flex-block__item">
                            <div class="calendar-flex-block__icon align-item--flex-start">
                                <svg width="25" height="25" viewBox="0 0 25 25" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <circle cx="12.5" cy="12.5" r="12.5" fill="#C4C4C4"/>
                                    <circle cx="12.5" cy="12.5" r="12.5" fill="#4DDBDB"/>
                                    <mask id="mask0" mask-type="alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="25" height="25">
                                        <circle cx="12.5" cy="12.5" r="12.5" fill="#C4C4C4"/>
                                        <circle cx="12.5" cy="12.5" r="12.5" fill="#4DDBDB"/>
                                    </mask>
                                    <g mask="url(#mask0)">
                                        <path d="M10.5 16.6243H14.375L15 22.2493H9.875L10.5 16.6243Z" fill="white"/>
                                        <path d="M14.3772 16.6243H10.5022L10.4586 17.0164C10.3411 18.0742 11.1691 18.9993 12.2334 18.9993H12.6459C13.7102 18.9993 14.5383 18.0742 14.4207 17.0164L14.3772 16.6243Z" fill="#4DDBDB"/>
                                        <ellipse cx="17.6875" cy="11.937" rx="2.0625" ry="2.1875" fill="white"/>
                                        <ellipse cx="7.1875" cy="11.9368" rx="2.0625" ry="2.1875" fill="white"/>
                                        <ellipse cx="12.4385" cy="11.3743" rx="6.0625" ry="6.375" fill="white"/>
                                        <ellipse cx="12.1875" cy="25.2493" rx="8.3125" ry="6" fill="white"/>
                                        <circle cx="14.9375" cy="11.3118" r="0.4375" fill="#4DDBDB"/>
                                        <circle cx="10.1875" cy="11.3118" r="0.4375" fill="#4DDBDB"/>
                                        <path d="M18.5012 9.8743C12.6887 11.5618 12.3804 6.3567 11.5637 6.0618C9.31371 5.2493 10.1887 8.49933 6.5012 9.8743C6.1887 8.20763 6.8887 4.81177 12.1887 4.81177C18.8137 4.81177 22.4916 8.71579 18.5012 9.8743Z" fill="#4DDBDB"/>
                                        <path d="M9.8125 8.31182C10.4792 8.22848 11.8125 8.43682 11.8125 9.93682C11.8125 11.4368 11.8125 12.8118 11.8125 13.3118L12.625 13.6243" stroke="#4DDBDB" stroke-width="0.535714"/>
                                        <path d="M12.3125 14.7671C12.8677 14.7671 13.6128 14.6009 14.0542 14.4887C13.986 14.6887 13.8466 14.8523 13.5998 15.0991C13.275 15.4239 12.8344 15.6064 12.375 15.6064C11.9156 15.6064 11.475 15.4239 11.1502 15.0991C10.9076 14.8565 10.769 14.6944 10.6995 14.4994C11.1097 14.6114 11.7742 14.7671 12.3125 14.7671Z" stroke="#4DDBDB" stroke-width="0.535714" stroke-linecap="round" stroke-linejoin="round"/>
                                    </g>
                                </svg>                        
                            </div>
                            <div class="calendar-flex-block__field">
                                <div class="calendar-flex-block__text">
                                    <strong>1 клиент</strong>
                                </div>
                                <div class="calendar-flex-block__text">
                                    <div class="calendar-flex-block__subtitle" data-info="clientName"></div>
                                </div>
                            </div>
                        </div>
                        <div class="calendar-flex-block__item">
                            <div class="calendar-flex-block__icon"></div>
                            <div class="calendar-flex-block__field">
                                <div class="calendar-flex-block__text">
                                    <ul class="calendar-flex-block__list">
                                        <li data-info="clientGender"></li>
                                        <li>
                                            <span data-info="clientAge"></span>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    `;
    elem.innerHTML += divForm;

    let eventModal = document.querySelector('.calendar-modal[data-modalid="schClientEvent"]'),
        actionButtons = document.querySelectorAll('[data-modalid="schClientEvent"] [data-action]'),
        timeLabel = options.intervalDay ? document.querySelectorAll('.calendar-date__label--time') : document.querySelector('.calendar-date__label--time'),
        timeBlock = document.querySelector('.calendar-date__time'),
        timeEndBlock = document.querySelector('.calendar-date__times--end'),
        allDayCheckbox = document.querySelector('#allDay'),
        formSchedule = document.forms.schedule;

    if (options.intervalDay) {
        timeLabel.forEach(el => {
            el.addEventListener("click", function() {
                timeEndBlock.classList.add('shown');
            });
        });

        allDayCheckbox.addEventListener("change", function() {
            if (this.checked) {
                timeBlock.classList.add("hidden");
            } else {
                timeBlock.classList.remove("hidden");
            }
        });
    } else {
    }

    actionButtons.forEach(el => {
        el.addEventListener("click", function() {
            if (this.dataset.action === "close") {
                eventModal.classList.remove("show");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "remove") {
                callback(formSchedule, eventModal, "remove");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "save") {
                callback(formSchedule, eventModal);
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            }
        });
    });
}

function generateForm(elem, userData) {
    let divForm = `
        <div class="calendar-modal" data-modalid="schEvent">
            <div class="calendar-modal__header">
                <div class="calendar-modal__element">
                    <button class="calendar-modal__button" data-action="close">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M26 14L14 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/> 
                            <path d="M14 14L26 26" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </div>
                <div class="calendar-modal__element">
                    <button class="calendar-modal__button" data-action="remove">
                        <svg width="40" height="40" viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <path d="M11 14H13H29" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M16 14V12C16 11.4696 16.2107 10.9609 16.5858 10.5858C16.9609 10.2107 17.4696 10 18 10H22C22.5304 10 23.0391 10.2107 23.4142 10.5858C23.7893 10.9609 24 11.4696 24 12V14M27 14V28C27 28.5304 26.7893 29.0391 26.4142 29.4142C26.0391 29.7893 25.5304 30 25 30H15C14.4696 30 13.9609 29.7893 13.5858 29.4142C13.2107 29.0391 13 28.5304 13 28V14H27Z" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M18 19V25" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                            <path d="M22 19V25" stroke="#2E3133" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                        </svg>
                    </button>
                </div>
            </div>
            <div class="calendar-modal__body">
                <form id="schedule" method="POST">
                    <input type="hidden" name="migxID" value="">
                    <input type="hidden" name="profileID" value="${userData.id}">
                    <div class="calendar-modal__block">
                        <input id="busy" class="form__checkbox form__checkbox--big login-tpl-form__item--input" type="checkbox" name="status" value="2" checked required />
                        <label for="busy" class="form__label login-tpl-form__item--label">Занят</label>
                    </div>
                    <div class="calendar-modal__block calendar-modal__block--column">
                        <div class="calendar-modal__group">
                            <span class="calendar-modal__span" data-info="dayName"></span>
                            <label data-info="date" for="date" class="calendar-date__label">
                                <span></span>
                                <input id="date" type="date" name="date">
                            </label>
                            <div class="calendar-date__times">
                                <span data-info="time"></span>
                                <label for="time" class="calendar-date__label--time">
                                    <select id="time" name="time" class="calendar-date__time">
                                        <option class="hidden-option" selected hidden disabled value="0">+ время</option>
                                        ${optionTime()}
                                    </select>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="calendar-modal__block">
                        <textarea class="form__input form__input--textarea" name="desc" id="desc" rows="6" placeholder="Добавить описание"></textarea>           
                    </div>
                    <div class="calendar-modal__block">
                        <input class="button button-size--normal button-theme--mint login-tpl-form__item--button" data-action="save" type="button" name="save-schedule" id="save-schedule" value="Сохранить" />        
                    </div>
                </form>
            </div>
        </div>
    `;
    elem.innerHTML += divForm;

    let eventModal = document.querySelector('.calendar-modal[data-modalid="schEvent"]'),
        actionButtons = document.querySelectorAll('[data-modalid="schEvent"] [data-action]'),
        timeLabel = options.intervalDay ? document.querySelectorAll('.calendar-date__label--time') : document.querySelector('.calendar-date__label--time'),
        timeBlock = document.querySelector('.calendar-date__time'),
        timeEndBlock = document.querySelector('.calendar-date__times--end'),
        allDayCheckbox = document.querySelector('#allDay'),
        formSchedule = document.forms.schedule;

    if (options.intervalDay) {
        timeLabel.forEach(el => {
            el.addEventListener("click", function() {
                timeEndBlock.classList.add('shown');
            });
        });

        allDayCheckbox.addEventListener("change", function() {
            if (this.checked) {
                timeBlock.classList.add("hidden");
            } else {
                timeBlock.classList.remove("hidden");
            }
        });
    }

    actionButtons.forEach(el => {
        el.addEventListener("click", function() {
            if (this.dataset.action === "close") {
                eventModal.classList.remove("show");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "remove") {
                callback(formSchedule, eventModal, "remove");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "save") {
                callback(formSchedule, eventModal);
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            }
        });
    });
}

function isHidden(element) {
    const elementRect = element.getBoundingClientRect();
    const elementHidesUp = elementRect.top < 0;
    const elementHidesLeft = elementRect.left < 0;
    const elementHidesDown = elementRect.bottom > window.innerHeight;
    const elementHidesRight = elementRect.right > window.innerWidth;
    const elementHides = elementHidesUp || elementHidesLeft || elementHidesDown || elementHidesRight;
    return elementHides;
}

function isVisible(elem) {
   return !!elem && !!( elem.offsetWidth || elem.offsetHeight || elem.getClientRects().length );
}

document.addEventListener('click', function(event) {
    if (!event.target.classList.contains('calendar-table--record')) {
        document.querySelectorAll('.calendar-modal').forEach(element => {
            if (!element.contains(event.target) && isVisible(element)) {
                element.classList.remove('show');
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            }
        });
    }
})

function setModalPosition(evElem, modal, evAction) {
    let dayName = document.querySelector('[data-info="dayName"]'),
        dataLabel = document.querySelector('[data-info="date"] span'),
        dataValue = document.querySelector('#date'),
        descField = document.querySelector('#desc'),
        timeField = document.querySelector('[data-info="time"]'),
        timeFieldOptions = document.querySelectorAll('.calendar-date__time option'),
        timeEndField = document.querySelector('[data-info="timeEnd"]'),
        timeEndBlock = document.querySelector('.calendar-date__times--end'),
        migxIDField = document.querySelector('[name="migxID"]'),
        allDayField = document.querySelector('#allDay'),
        removeButton = document.querySelector('[data-action="remove"]'),
        saveButton = document.querySelector('[data-action="save"]'),
        statusField = document.querySelector('#busy'),
        posX = 0,
        posY = 0;

    dayName.innerHTML = evElem.dataset.day + ", ";
    dataValue.value = evElem.dataset.date;
    dataLabel.innerHTML = evElem.dataset.readdate;
    saveButton.style.display = null;
    removeButton.style.display = "none";

    timeFieldOptions.forEach(element => {
        if (element.hasAttribute("selected") && element.value != "0") {
            element.removeAttribute("selected");
        }
    });

    if (evAction.action === "editEvent") {
        let dayTime = evAction.time,
            dayEndTime = evAction.timeend,
            migxID = evAction.migxid,
            dayStatus = evAction.status,
            dayAll = evAction.allday
            dayDesc = evAction.desc;

        evElem = evElem.parentElement.parentElement;
        timeFieldOptions.forEach(element => {
            if (element.innerHTML === dayTime) {
                element.setAttribute("selected", "selected");
            }
        });
        
        migxIDField.value = migxID;
        descField.innerHTML = dayDesc;
        timeField.innerHTML = dayTime;
        statusField.checked = dayStatus == 2 ? 1 : 0;

        if (evElem.parentElement.dataset.calendarday === 'current' || 
            evElem.parentElement.dataset.calendarday === 'outdate') {
            removeButton.style.display = "none";
            saveButton.style.display = "none";
        } else {
            removeButton.style.display = null;
        }

        if (options.intervalDay) {
            timeEndBlock.classList.add('shown');
            timeEndField.children[1].value = dayEndTime;
            allDayField.checked = Number(dayAll);
        }
    } else {
        migxIDField.value = "";
        descField.innerHTML = "";
        timeField.innerHTML = "";

        timeFieldOptions.forEach(element => {
            if (element.hasAttribute("selected") && element.value != "0") {
                element.removeAttribute("selected");
            }
        });

        if (options.intervalDay) {
            timeEndBlock.classList.remove('shown');
            timeEndField.children[1].value = "";
            allDayField.checked = 0;
        }
    }
    
    modal.classList.add("show");
    document.querySelector(".calendar-modal--overlay").classList.add("shown");

    if (!evElem.classList.contains('calendar-table--col--content')) {
        posX = evElem.offsetLeft - modal.offsetWidth;
        posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2);
    } else {
        posX = evElem.offsetParent.offsetLeft - modal.offsetWidth;
        posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2);
    }

    if (window.innerWidth > 992) {
        modal.style.left = posX + "px";
        modal.style.top = posY + "px";
    } else {
        modal.style.left = "15px";
        modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
    }

    let elementRect = modal.getBoundingClientRect(),
        elementHidesUp = elementRect.top < 0,
        elementHidesDown = elementRect.bottom > window.innerHeight,
        elementHidesLeft = elementRect.left < 0;

    if (isHidden(modal)) {
        if (!evElem.classList.contains('calendar-table--col--content')) {
            posX = evElem.offsetLeft + evElem.offsetWidth;

            if (elementHidesDown) {
                if (evElem.dataset.modalid == "showmore") {
                    posX = evElem.offsetLeft - modal.offsetWidth;
                }

                offsetBottom = window.innerHeight - elementRect.bottom;
                posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2) + offsetBottom;
            } else if (elementHidesUp) { 
                offsetTop = elementRect.top;
                posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2) - offsetTop;
            }

            if (elementHidesLeft && elementHidesDown) {
                if (evElem.dataset.modalid == "showmore") {
                    posX = evElem.offsetLeft + evElem.offsetWidth;
                }
            }

            if (window.innerWidth > 992) {
                modal.style.left = posX + "px";
                modal.style.top = posY + "px";
            } else {
                modal.style.left = "15px";
                modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
            }
        } else {
            if (elementHidesDown) {
                offsetBottom = window.innerHeight - elementRect.bottom;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2) + offsetBottom;
            } else if (elementHidesUp) { 
                offsetTop = elementRect.top;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2) - offsetTop;
            } else {
                posX = evElem.offsetParent.offsetLeft + evElem.offsetParent.offsetWidth;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2);
            }

            if (window.innerWidth > 992) {
                modal.style.left = posX + "px";
                modal.style.top = posY + "px";
            } else {
                modal.style.left = "15px";
                modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
            }
        }
    }
}

function setModalClientPosition(evElem, modal, evAction) {
    let dayName = document.querySelector('[data-info="dayNameClient"]'),
        clientName = document.querySelectorAll('[data-info="clientName"]'),
        clientGender = document.querySelector('[data-info="clientGender"]'),
        clientAge = document.querySelector('[data-info="clientAge"]'),
        dataLabel = document.querySelector('[data-info="dateClient"] span'),
        dataValue = document.querySelector('#date'),
        descField = document.querySelector('#desc'),
        timeField = document.querySelector('[data-info="timeClient"]'),
        timeFieldOptions = document.querySelectorAll('.calendar-date__time option'),
        migxIDField = document.querySelector('[name="migxID"]'),
        zoomLink = document.querySelector("#zoomLink"),
        posX = 0,
        posY = 0;

    dayName.innerHTML = evElem.dataset.day + ", ";
    dataValue.value = evElem.dataset.date;
    dataLabel.innerHTML = evElem.dataset.readdate;

    timeFieldOptions.forEach(element => {
        if (element.hasAttribute("selected") && element.value != "0") {
            element.removeAttribute("selected");
        }
    });

    if (evAction.action === "editEvent") {
        let dayTime = evAction.time,
            dayEndTime = evAction.timeend,
            migxID = evAction.migxid,
            dayDesc = evAction.desc;

        clientName.forEach(element => {
            element.innerHTML = evAction.client;
        });

        clientGender.innerHTML = evAction.gender === 1 ? 'Женский' : 'Мужской';
        clientAge.innerHTML = evAction.age;
        zoomLink.value = evAction.zoom;

        evElem = evElem.parentElement.parentElement;
        timeFieldOptions.forEach(element => {
            if (element.innerHTML === dayTime) {
                element.setAttribute("selected", "selected");
            }
        });

        migxIDField.value = migxID;
        descField.innerHTML = dayDesc;
        timeField.innerHTML = dayTime;

        if (options.intervalDay) {
            timeEndBlock.classList.add('shown');
            timeEndField.classList.add('showtime');
            timeEndField.children[1].value = dayEndTime;
        }
    } else {
        migxIDField.value = "";
        descField.innerHTML = "";
        timeField.innerHTML = "";

        timeFieldOptions.forEach(element => {
            if (element.hasAttribute("selected") && element.value != "0") {
                element.removeAttribute("selected");
            }
        });

        if (options.intervalDay) {
            timeEndBlock.classList.remove('shown');
            timeEndField.classList.remove('showtime');
            timeEndField.children[1].value = "";
        }
    }
    
    modal.classList.add("show");
    document.querySelector(".calendar-modal--overlay").classList.add("shown");

    if (!evElem.classList.contains('calendar-table--col--content')) {
        posX = evElem.offsetLeft - modal.offsetWidth;
        posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2);
    } else {
        posX = evElem.offsetParent.offsetLeft - modal.offsetWidth;
        posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2);
    }

    if (window.innerWidth > 992) {
        modal.style.left = posX + "px";
        modal.style.top = posY + "px";
    } else {
        modal.style.left = "15px";
        modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
    }

    let elementRect = modal.getBoundingClientRect(),
        elementHidesUp = elementRect.top < 0,
        elementHidesDown = elementRect.bottom > window.innerHeight,
        elementHidesLeft = elementRect.left < 0;

    if (isHidden(modal)) {
        if (!evElem.classList.contains('calendar-table--col--content')) {
            posX = evElem.offsetLeft + evElem.offsetWidth;

            if (elementHidesDown) {
                if (evElem.dataset.modalid == "showmore") {
                    posX = evElem.offsetLeft - modal.offsetWidth;
                }

                offsetBottom = window.innerHeight - elementRect.bottom;
                posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2) + offsetBottom;
            } else if (elementHidesUp) { 
                offsetTop = elementRect.top;
                posY = evElem.offsetTop - (modal.offsetHeight / 2 - evElem.offsetHeight / 2) - offsetTop;
            }

            if (elementHidesLeft && elementHidesDown) {
                if (evElem.dataset.modalid == "showmore") {
                    posX = evElem.offsetLeft + evElem.offsetWidth;
                }
            }

            if (window.innerWidth > 992) {
                modal.style.left = posX + "px";
                modal.style.top = posY + "px";
            } else {
                modal.style.left = "15px";
                modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
            }
        } else {
            if (elementHidesDown) {
                offsetBottom = window.innerHeight - elementRect.bottom;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2) + offsetBottom;
            } else if (elementHidesUp) { 
                offsetTop = elementRect.top;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2) - offsetTop;
            } else {
                posX = evElem.offsetParent.offsetLeft + evElem.offsetParent.offsetWidth;
                posY = evElem.offsetParent.offsetTop - (modal.offsetHeight / 2 - evElem.offsetParent.offsetHeight / 2);
            }

            if (window.innerWidth > 992) {
                modal.style.left = posX + "px";
                modal.style.top = posY + "px";
            } else {
                modal.style.left = "15px";
                modal.style.top = `calc(50% - ${modal.offsetHeight / 2}px)`;
            }
        }
    }
}

function getDayName(currentDay) {
    let names = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"];
    return names[currentDay];
}

function getMonthName(currentMonth) {
    let names = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"];
    return names[currentMonth];
}

function callback(formElement, modal, action = "") {
    document.body.classList.remove('loaded');
    
    let formData = new FormData(formElement),
        xhr = new XMLHttpRequest();

    formData.append('action', action);

    xhr.open("POST", "/assets/php/addSchedule.php", true);
    xhr.onreadystatechange = function() {
        if (this.readyState != 4) return;
        let result = JSON.parse(this.responseText);

        alerts({
            state: result.state,
            message: result.message
        });

        modal.classList.remove("show");
        document.querySelector(".calendar-modal--overlay").classList.remove("shown");

        userData.schedule = result.res;
        createCalendar(calendar, month, year, userData);
    }
    xhr.send(formData);
}

let date = new Date(),
    month = date.getMonth(),
    year = date.getFullYear();

function getCurrentDate(action = "") {
    let calendarTitle = document.querySelector('[data-action="title"]');

    if (action === "next") {
        month += 1;
        if (month > 11) {
            month = 0;
            year += 1;
        }
    } else if (action === "prev") {
        month -= 1;
        if (month < 0) {
            month = 11;
            year -= 1;
        }
    }

    diff = 2;

    if (window.innerWidth >= 992 && window.innerWidth < 1200) {
        diff = 1;
    } else if (window.innerWidth < 992) { 
        diff = 50;
    } else {
        diff = 2;
    }

    window.addEventListener('resize', function(event) {
        if (window.innerWidth >= 992 && window.innerWidth < 1200) {
            diff = 1;
        } else if (window.innerWidth < 992) { 
            diff = 50;
        } else {
            diff = 2;
        }

        let eventModal = document.querySelector('.calendar-modal[data-modalid="schEvent"]'),
        actionButtons = document.querySelectorAll('[data-modalid="schEvent"] [data-action]'),
        formSchedule = document.forms.schedule;

        actionButtons.forEach(el => {
            el.addEventListener("click", function() {
                if (this.dataset.action === "close") {
                    eventModal.classList.remove("show");
                    document.querySelector(".calendar-modal--overlay").classList.remove("shown");
                } else if (this.dataset.action === "remove") {
                    callback(formSchedule, eventModal, "remove");
                    document.querySelector(".calendar-modal--overlay").classList.remove("shown");
                } else if (this.dataset.action === "save") {
                    callback(formSchedule, eventModal);
                    document.querySelector(".calendar-modal--overlay").classList.remove("shown");
                }
            });
        });

        let actionButtonsMore = document.querySelectorAll('[data-modalid="showmore"] [data-action]'),
            eventModals = document.querySelectorAll('.calendar-modal[data-modalid]');
        
        actionButtonsMore.forEach(el => {
            el.addEventListener("click", function(e) {
                e.stopPropagation();
                e.preventDefault();

                if (this.dataset.action === "editEvent") {
                    setModalPosition(this, findInNodeList(eventModals, "schEvent"), el.dataset);
                }
            });
        });
    });
    
    window.watch("diff", function(id, oldVal, newVal){
        createCalendar(calendar, month, year, userData, newVal);
    });

    createCalendar(calendar, month, year, userData, diff);
    calendarTitle.innerHTML = `${getMonthName(month)} ${year}`;

    let eventModal = document.querySelector('.calendar-modal[data-modalid="schEvent"]'),
        actionButtons = document.querySelectorAll('[data-modalid="schEvent"] [data-action]'),
        formSchedule = document.forms.schedule;

    actionButtons.forEach(el => {
        el.addEventListener("click", function() {
            if (this.dataset.action === "close") {
                eventModal.classList.remove("show");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "remove") {
                callback(formSchedule, eventModal, "remove");
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            } else if (this.dataset.action === "save") {
                callback(formSchedule, eventModal);
                document.querySelector(".calendar-modal--overlay").classList.remove("shown");
            }
        });
    });

    let actionButtonsMore = document.querySelectorAll('[data-modalid="showmore"] [data-action]'),
        eventModals = document.querySelectorAll('.calendar-modal[data-modalid]');
    
    actionButtonsMore.forEach(el => {
        el.addEventListener("click", function(e) {
            e.stopPropagation();
            e.preventDefault();

            if (this.dataset.action === "editEvent") {
                setModalPosition(this, findInNodeList(eventModals, "schEvent"), el.dataset);
            }
        });
    });
}

document.addEventListener('DOMContentLoaded', function() {
    let buttons = document.querySelectorAll('.calendar-content__button');

    getCurrentDate();

    buttons.forEach(el => {
        el.addEventListener("click", function() {
            getCurrentDate(this.dataset.action);
        });
    });
});