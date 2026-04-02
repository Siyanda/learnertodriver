import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  submitOnChange() {
    this.element.requestSubmit()
  }
}
