document.addEventListener('turbo:load', function () {
  const calendar = document.querySelector(".calendar");
  if(!calendar){
    return;
  }
  const date = document.querySelector(".date");
  const daysContainer = document.querySelector(".days");
  const prev = document.querySelector(".prev");
  const next = document.querySelector(".next");
  const gotoBtn = document.querySelector(".goto-btn");
  const todayBtn = document.querySelector(".today-btn");
  const dateInput = document.querySelector(".date-input");


  let selectedDate = null;
  let eventDates;
  try {
    eventDates = JSON.parse(calendar.dataset.eventDates);
  } catch(e){
    console.error('некорректный JSON', e);
    eventDates = [];
  }
  console.log(eventDates);

  let today = new Date();
  let activeDay;
  let month = today.getMonth();
  let year = today.getFullYear()

  const months = [
    "Январь",
    "Февраль",
    "Март",
    "Апрель",
    "Май",
    "Июнь",
    "Июль",
    "Август",
    "Сентябрь",
    "Октябрь",
    "Ноябрь",
    "Декабрь"
  ];
  function initCalendar() {
    const firstDay = new Date(year, month, 1);
    const lastDay = new Date(year, month + 1, 0);
    const prevLastDay = new Date(year, month, 0);
    const prevDays = prevLastDay.getDate();
    const lastDate = lastDay.getDate();
    let x = firstDay.getDay();
    if (x == 0) {
      x = 7;
    }
    const day = x;
    let y = lastDay.getDay();
    if (y == 0) {
      y = 7;
    }
    const nextDays = 7 - y;
    console.log(day);

    date.innerHTML = months[month] + " " + year;


    let days = "";

    for (let z = day; z > 1; z--) {
      days += `<div class="day prev-date">${prevDays - z + 2}</div>`;
    }


    for (let i = 1; i < lastDate + 1; i++) {
      if (i == new Date().getDate() && year == new Date().getFullYear() && month == new Date().getMonth()) {
        days += `<div class="day today">${i}</div>`;
      }
      else
        days += `<div class="day">${i}</div>`;
    }

    for (let j = 1; j < nextDays + 1; j++) {
      days += `<div class="day next-date">${j}</div>`;
    }
    daysContainer.innerHTML = days;
    highlightEventDays();
  }

  initCalendar();

  function prevMonth() {
  month--;
  if (month < 0) {
    month = 11;
    year--;
  }
  selectedDate = null;
  initCalendar();
}

function nextMonth() {
  month++;
  if (month > 11) {
    month = 0;
    year++;
  }
  selectedDate = null;
  initCalendar();
  }
  prev.addEventListener("click", prevMonth);
  next.addEventListener("click", nextMonth);

  todayBtn.addEventListener("click", () => {
    today = new Date();
    month = today.getMonth();
    year = today.getFullYear();
    initCalendar();
  })
  dateInput.addEventListener("input", (e) => {
    dateInput.value = dateInput.value.replace(/[^0-9.]/g, "");
    if(dateInput.value.length == 2){
      dateInput.value += ".";
    }
    if(e.inputType == "insertText"){
      if (dateInput.value.length == 3){
        if (dateInput.value.slice(-1) != '.'){
        dateInput.value = dateInput.value.slice(0, 2) + '.' + dateInput.value.slice(-1);
        }
      }
    }
    if(dateInput.value.length > 7){
      dateInput.value = dateInput.value.slice(0, 7);
    }
    if(e.inputType == "deleteContentBackward") {
      if(dateInput.value.length == 3) {
        dateInput.value = dateInput.value.slice(0, 2);
      }
    }
  });

  gotoBtn.addEventListener("click", gotoDate);
  function gotoDate(){
    const dateArr = dateInput.value.split(".");
    if(dateArr.length == 2) {
      if(dateArr[0] > 0 && dateArr[0] <13 && dateArr[1].length == 4){
        month = dateArr[0] - 1;
        year = dateArr[1];
        initCalendar();
        return;
      }
    }
    alert('Неверный формат даты');
  }









  const eventDay = document.querySelector(".event-day");
  const eventDate = document.querySelector(".event-date");
  const eventsContainer = document.querySelector(".events");
  const addEvent = document.querySelector(".add-event");
  const addEventBtn = document.querySelector(".add-event-btn");
  const hiddenAddEvent = document.querySelector(".hidden-add-event");
  const eventMonths = [
    "Января",
    "Февраля",
    "Марта",
    "Апреля",
    "Мая",
    "Июня",
    "Июля",
    "Августа",
    "Сентября",
    "Октября",
    "Ноября",
    "Декабря"
  ];
  const eventWeekdays = [
    "Вс",
    "Пн",
    "Вт",
    "Ср",
    "Чт",
    "Пт",
    "Сб"
  ]

  addEventBtn.addEventListener("mouseover", openEvent);
  addEventBtn.addEventListener("mouseout", closeEvent);
  function openEvent(){
    hiddenAddEvent.classList.add("hidden-text");}
  function closeEvent(){
    hiddenAddEvent.classList.remove("hidden-text");}


  function highlightEventDays(){
    document.querySelectorAll(".day").forEach(dayElement =>{
      const dayNumber = Number(dayElement.textContent);
      const isPrevDate = dayElement.classList.contains("prev-date");
      const isNextDate = dayElement.classList.contains("next-date");
      let dayMonth = month;
      let dayYear = year;
      if (isPrevDate){
        dayMonth--;
        if (dayMonth < 0){
          dayMonth = 11;
          dayYear--;
        }
      }else if (isNextDate){
        dayMonth++;
        if (dayMonth > 11){
          dayMonth = 0;
          dayYear++;
        }
      }
      const dateStr = `${dayYear}-${String(dayMonth + 1).padStart(2, '0')}-${String(dayNumber).padStart(2, '0')}`;
      if (eventDates.includes(dateStr)){
        dayElement.classList.add("has-event");
      }
    });
  }

  daysContainer.addEventListener('click', function(e) {
    const dayElement = e.target.closest(".day");
    if(!dayElement){
      return;
    }
    const dayNumber = Number(dayElement.textContent);
    const isPrevDate = dayElement.classList.contains("prev-date");
    const isNextDate = dayElement.classList.contains("next-date");
    let dayMonth = month;
    let dayYear = year;

    if (isPrevDate){
      dayMonth--;
      if(dayMonth < 0){
        dayMonth = 11;
        dayYear--; 
      }
    }else if(isNextDate){
      dayMonth++;
      if(dayMonth > 11){
        dayMonth = 0;
        dayYear++;
      }
    }
    selectedDate = `${dayYear}-${String(dayMonth + 1).padStart(2, '0')}-${String(dayNumber).padStart(2, '0')}`;
    updateRight(selectedDate);
    document.querySelectorAll(".day").forEach(item => item.classList.remove("active"));
    dayElement.classList.add("active");
  });

  async function updateRight(dateStr){
    const dateItem = new Date(dateStr);
    eventDay.textContent = eventWeekdays[dateItem.getDay()];
    eventDate.textContent = `${dateItem.getDate()} ${eventMonths[dateItem.getMonth()]} ${dateItem.getFullYear()}`;

    
    try{
      const response = await fetch(`/events/day_events?date=${dateStr}`);
      const events = await response.json();
      if (events.length === 0){
        eventsContainer.innerHTML = '<p class="calendar-no-events">В этот день нет запланированных мероприятий</p>';
      }else{
        let html = '';
        events.forEach(event =>{
          html += `
          <div class="event">
            <div class="title">
              <h3 class="calendar-event-title">${event.title}</h3>
            </div>
            <div class="calendar-event-time-location">${event.start_time.slice(11, 16)} - ${event.location}</div>
          </div>
          `;
        });
        eventsContainer.innerHTML = html;
      }
    }catch(e){
      console.error("Ошибка загрузки событий", e);
      eventsContainer.innerHTML = "<p>Ошибка загрузки</p>";
    }
  }

  addEventBtn.addEventListener('click', function(){
    if(selectedDate){
      window.location.href=`/events/new?event_date=${selectedDate}`;
      console.log(1);
    }else{
    window.location.href="/events/new";
  }
  });
});

