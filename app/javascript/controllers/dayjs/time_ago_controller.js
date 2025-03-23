import { Controller } from "@hotwired/stimulus"
import dayjs from "dayjs"

const relativeTime = require("dayjs/plugin/relativeTime");
dayjs.extend(relativeTime);

export default class extends Controller {

  static get targets() {
    return ["formattedTime"]
  }

  static values = {
    timeStamp: String
  }

  initialize() {
    this.updateText()
    this.autoSlide()
  }

  autoSlide() {
    this.interval = setInterval(() => { console.log("1 min")}, 60000)

    this.timeout = setTimeout(() => {
      console.log("end")
    }, 60000)
  }

  updateText() {
    this.formattedTimeTarget.innerText = dayjs(this.timeStampValue).fromNow()
  }
}
