import { Controller } from '@hotwired/stimulus'
import dayjs from 'dayjs'

const relativeTime = require('dayjs/plugin/relativeTime');
dayjs.extend(relativeTime);

export default class extends Controller {

  static get targets() {
    return ['formattedTime']
  }

  static values = {
    timeStamp: String
  }

  initialize() {
    this.updateText()
  }

  updateText() {
    this.formattedTimeTarget.innerText = dayjs(this.timeStampValue).fromNow()
  }

  everyMinute() {
      // set timeout to update time every minute for 60 minutes, then every hour for 24 hours, then daily
  }

  everyHour() {
      // set timeout to update time every minute for 60 minutes, then every hour for 24 hours, then daily
  }

  everyDay() {
      // set timeout to update time every minute for 60 minutes, then every hour for 24 hours, then daily
  }

}
