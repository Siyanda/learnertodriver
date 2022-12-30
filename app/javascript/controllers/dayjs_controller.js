import { Controller } from "@hotwired/stimulus"
import dayjs from 'dayjs'

var relativeTime = require('dayjs/plugin/relativeTime');
dayjs.extend(relativeTime);

var duration = require('dayjs/plugin/duration');
dayjs.extend(duration);

export default class extends Controller {

  static get targets() {
    return ['formattedTime', 'time_ago_in_words', 's_to_duration']
  }

  initialize() {
    
  }

  trimmed(rawText) {
    return rawText.replace(/[\n\r]+|[\s]{2,}/g, ' ').trim();
  }

  to_duration(dateText) {

  }

  to_date_time() {

  }

  time_ago(dateText) {

  }
}
