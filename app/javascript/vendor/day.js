// move to stimulus controller

import dayjs from 'dayjs'

document.addEventListener("turbo:load", () => {

var relativeTime = require('dayjs/plugin/relativeTime');
dayjs.extend(relativeTime);

  let dateContainer = document.getElementsByClassName("time_ago_in_words");
  if (dateContainer) {
    let allDates = Array.from(dateContainer);

    allDates.forEach(
      function(element) {
        let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
        let formatedDate = dayjs().to(dayjs(dateText));
        element.innerHTML = formatedDate;
    }
  )}

  let timeContainer = document.getElementsByClassName("formatted_time");
  if (timeContainer) {
    let allTimes = Array.from(timeContainer);

    allTimes.forEach(
      function(element) {
      let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
      let formatedTime = dayjs(dateText).format('D MMM YYYY');
      element.innerHTML = formatedTime; 
    })
  }

})
