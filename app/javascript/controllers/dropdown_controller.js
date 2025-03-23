import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ["menu"]
  }

  toggle() {
    this.menuTarget.classList.toggle("active");
  }
}
