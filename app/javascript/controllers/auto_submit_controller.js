import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitOnChange(event) {
    this.element.requestSubmit()
  }
}
