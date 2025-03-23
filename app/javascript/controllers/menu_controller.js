import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ["option", "icon"]
  }

  toggle() {
    this.optionTarget.classList.toggle("active");
    this.iconTarget.classList.toggle("active");
  }
}
