import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

 static values = {
                   state: { type: String, default: "start" },
                   total: { type: Number, default: 0 },
                   index: { type: Number, default: 0 }
                  }

  static targets = [ "slide", "progress", "controls" ]

  indexValueChanged() {
    this.currentSlide()
    this.sliderState()
  }

  next() {
    (this.indexValue < this.totalValue -1 ) ? this.indexValue++ : this.indexValue
  }

  previous() {
    (this.indexValue > 0) ? this.indexValue-- : this.indexValue
  }

  currentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    })
  }

  sliderState() {
    let position = this.indexValue
    let total = this.totalValue - 1

    return position > 0 && (position == total) ? this.stateValue = "end"
      : position == 0 && (position < total) ? this.stateValue = "start"
      : position > 0 && (position < total) ? this.stateValue = "in_progress"
      : this.stateValue = "at_start_end_and_in_progress";
  }
}
