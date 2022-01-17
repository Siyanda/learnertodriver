// move to stimulus controller

import dayjs from 'dayjs'

document.addEventListener("turbo:load", () => {

  var relativeTime = require('dayjs/plugin/relativeTime');
  dayjs.extend(relativeTime);

  var duration = require('dayjs/plugin/duration');
  dayjs.extend(duration);

  let timeAgoContainer = document.getElementsByClassName("time_ago_in_words");
  if (timeAgoContainer) {
    let allDates = Array.from(timeAgoContainer);

    allDates.forEach(
      function(element) {
        let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
        let formatedDate = dayjs().to(dayjs(dateText));
        element.innerHTML = formatedDate;
    }
  )}

  let durationContainer = document.getElementsByClassName("s_to_duration");

  if (durationContainer) {
    let allDates = Array.from(durationContainer);

    allDates.forEach(
      function(element) {
        dayjs.extend(duration)
        let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
        let asDuration = dayjs.duration(dateText, "seconds").humanize();
        element.innerHTML = `about ${asDuration} long`;
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
