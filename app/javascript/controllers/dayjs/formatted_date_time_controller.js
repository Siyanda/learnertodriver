import { Controller } from "@hotwired/stimulus"
import dayjs from "dayjs"

export default class extends Controller {

  static get targets() {
    return ["formattedTime"]
  }

  static values = {
    date: String
  }

  initialize() {
    this.updateText()
  }

  updateText() {
    this.formattedTimeTarget.innerText = dayjs(this.dateValue).format("MMMM D, YYYY h:mm A")
  }
}
