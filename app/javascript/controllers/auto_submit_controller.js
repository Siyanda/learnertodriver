import { Controller } from "@hotwired/stimulus"

// Saves the quiz answer as soon as a choice is picked.
export default class extends Controller {
  submitOnChange() {
    this.element.requestSubmit()
  }
}
