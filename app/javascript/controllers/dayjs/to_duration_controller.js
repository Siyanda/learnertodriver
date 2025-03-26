import { Controller } from "@hotwired/stimulus"
import dayjs from "dayjs"

const duration = require("dayjs/plugin/duration");
dayjs.extend(duration);

export default class extends Controller {

  static get targets() {
    return ["formattedTime"]
  }

  static values = {
    timeStamp: String
  }

  initialize() {
    this.updateText()
  }

  updateText() {
    this.formattedTimeTarget.innerText = `about ${dayjs.duration(this.timeStampValue, "seconds").humanize()} long`
  }
}
