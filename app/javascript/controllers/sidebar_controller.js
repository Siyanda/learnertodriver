import { Controller } from "@hotwired/stimulus"

// Toggles the admin sidebar on small screens.
export default class extends Controller {
  static targets = ["bar"]

  toggle() {
    this.barTargets.forEach((bar) => bar.classList.toggle("open"))
  }
}
