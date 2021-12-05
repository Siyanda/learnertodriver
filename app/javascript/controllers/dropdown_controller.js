import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ['menu']
  }

  toggle(event) {
    this.menuTarget.classList.toggle('active');
  }
}
