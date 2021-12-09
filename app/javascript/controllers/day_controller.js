import { Controller } from "@hotwired/stimulus"
import dayjs from 'dayjs'

var relativeTime = require('dayjs/plugin/relativeTime');
dayjs.extend(relativeTime);

export default class extends Controller {

  static get targets() {
    return ['formattedTime']
  }

  initialize() {
    
  }

  trim(rawText) {
    return rawText.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
  }

  format(dateText) {
    // element.innerHTML = dayjs(trimmedText).format('D MMM YYYY');
  }

  time_ago(dateText) {
    // let formatedDate = dayjs().to(dayjs(dateText));
  }
}
