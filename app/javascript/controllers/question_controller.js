import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ['question']
  }

  connect() {
    console.log("test");
  }
}
