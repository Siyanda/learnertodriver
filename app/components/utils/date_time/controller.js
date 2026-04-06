import { Controller as BaseController } from "@hotwired/stimulus"
import dayjs        from 'dayjs'
import duration     from 'dayjs/plugin/duration'
import relativeTime from 'dayjs/plugin/relativeTime'

dayjs.extend(duration)
dayjs.extend(relativeTime)

function getRelativeTimeString(isoTime) {
  return dayjs(isoTime).fromNow()
}

function getNextInterval(ageInSeconds) {
  if (ageInSeconds < 60)    return 1000
  if (ageInSeconds < 3600)  return 60 * 1000
  if (ageInSeconds < 86400) return 60 * 60 * 1000
  return null
}

export default class extends BaseController {
  static targets = ['formattedTime']
  static values = {
    timeStamp: String,
    format: String
  }

  connect() {
    console.log("ddd");
    this.updateText()
    if (this.formatValue === 'time_ago') this.scheduleNextUpdate()
  }

  disconnect() {
    if (this.timeout) clearTimeout(this.timeout)
  }

  updateText() {
    this.element.innerText = this.formatted
  }

  get formatted() {
    switch (this.formatValue) {
      case 'date':     return dayjs(this.timeStampValue).format('D MMM YYYY')
      case 'time_ago': return getRelativeTimeString(this.timeStampValue)
      case 'duration': return `about ${dayjs.duration(this.timeStampValue, 'seconds').humanize()} long`
      default:         return this.timeStampValue
    }
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
