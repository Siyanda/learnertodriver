import { Controller } from '@hotwired/stimulus'
import dayjs from 'dayjs'

export default class extends Controller {

  static get targets() {
    return ['formattedTime']
  }

  static values = {
    timeStamp: String
  }

  initialize() {
    updateText()
  }

  updateText() {
    this.formattedTimeTarget.innerText = dayjs(this.timeStampValue).format('D MMM YYYY')
  }
}
