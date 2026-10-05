import { Controller } from "@hotwired/stimulus"

// Adds and removes `fields_for` rows. New rows are cloned from a <template>
// whose child index placeholder is NEW_RECORD.
export default class extends Controller {
  static targets = ["target", "template"]

  add(event) {
    event.preventDefault()

    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, Date.now().toString())
    this.targetTarget.insertAdjacentHTML("beforebegin", content)
  }

  remove(event) {
    event.preventDefault()

    const wrapper = event.target.closest(".nested-fields")

    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove()
      return
    }

    wrapper.querySelector("input[name*='_destroy']").value = "1"
    wrapper.querySelectorAll("[required]").forEach((input) => input.removeAttribute("required"))
    wrapper.hidden = true
  }
}
