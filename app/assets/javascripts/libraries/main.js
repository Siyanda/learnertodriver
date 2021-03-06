document.addEventListener("turbo:load", function() {
  dayjs.extend(window.dayjs_plugin_relativeTime);

  let dateContainer = document.getElementsByClassName("time_in_words")

  if (dateContainer.length > 0) {
    let allDates = Array.from(dateContainer);

      allDates.forEach(function(element) {
        let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
        let formatedDate = dayjs().to(dayjs(dateText));
        element.innerHTML = formatedDate;
    });
  }

  let timeContainer = document.getElementsByClassName("formatted_time")

  if (timeContainer.length > 0) {
    let allDates = Array.from(timeContainer);

      allDates.forEach(function(element) {
        let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
        let formatedDate = dayjs(dateText).format('D MMM YYYY');
        element.innerHTML = formatedDate;
    });
  }
});

