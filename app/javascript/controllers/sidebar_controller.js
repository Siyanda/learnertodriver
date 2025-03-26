import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ["logo", "icon", "wrapper", "bar"]
  }

  toggle() {
    this.iconTarget.classList.toggle("hidden");
    this.logoTarget.classList.toggle("hidden");

    this.wrapperTarget.classList.toggle("right-side");
    this.barTarget.classList.toggle("hidden");
  }
}
