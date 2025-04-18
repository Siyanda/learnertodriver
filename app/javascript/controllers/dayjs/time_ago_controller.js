import { Controller } from '@hotwired/stimulus'
import { getRelativeTimeString, getNextInterval } from '../../utils/time_ago.js'
import dayjs from 'dayjs'

export default class extends Controller {
  static targets = ['formattedTime']
  static values = { timeStamp: String }

  connect() {
    this.updateText()
    this.scheduleNextUpdate()
  }

  disconnect() {
    if (this.timeout) clearTimeout(this.timeout)
  }

  updateText() {
    const formatted = getRelativeTimeString(this.timeStampValue)
    this.formattedTimeTarget.innerText = formatted
  }

  scheduleNextUpdate() {
    const ageInSeconds = dayjs().diff(dayjs(this.timeStampValue), 'second')
    const delay = getNextInterval(ageInSeconds)

    if (delay !== null) {
      this.timeout = setTimeout(() => {
        this.updateText()
        this.scheduleNextUpdate()
      }, delay)
    }
  }
}
