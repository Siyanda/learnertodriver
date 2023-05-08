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
    this.autoSlide()
  }

   autoSlide() {
    this.interval = setInterval(() => { console.log('1 min')}, 60000)

    this.timeout = setTimeout(() => {
      console.log("end")
    }, 60000)
  }

  updateText() {
    this.formattedTimeTarget.innerText = dayjs(this.timeStampValue).fromNow()
  }

  atInterval(task,interval,end) {
    setTimeout(() => { clearInterval(timerId); alert('stop'); }, 5000);
    let timerId = setInterval(() => alert('tick'), 2000);
    // set timeout to update time every minute for 60 minutes, then every hour for 24 hours, then daily
  }
}
