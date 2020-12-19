import { formatDistanceToNow, parseISO } from 'date-fns'

document.addEventListener("turbolinks:load", function() {

  let dateContainer = document.getElementsByClassName("time_in_words")
  if (dateContainer.length > 0) {

  let allDates = Array.from(dateContainer);

      // find all dates on page
      allDates.forEach(function(element) {

      // extract date from element
      let dateText = element.textContent.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim()
      // change date to human readable format
      let formatedDate = formatDistanceToNow(
        new Date(parseISO(dateText, 1)),{addSuffix: true}
      )
      // apply formated date to element
      element.innerHTML = formatedDate;
    })
    ;

  }
})
;
