import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

 static values = {
                   state: { type: String, default: 'start' },
                   index: { type: Number, default: 0 }
                  }

  static targets = [ 'slide', 'progress', 'controls' ]

  indexValueChanged() {
    this.currentSlide()
    this.sliderState()
  }

  stateValueChanged() {
   console.log(this.stateValue)
  }

  next() {
    this.indexValue++
  }

  previous() {
    this.indexValue--
  }

  currentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index != this.indexValue
    })
  }

  sliderState() {
    let i = this.indexValue
    let max = parseInt(this.slideTargets.length - 1)

    if (i == 0) {
      this.stateValue = 'start'
    } else if (i == max) {
      this.stateValue = 'end'
    } else {
      this.stateValue = 'during'
    }
  }
}
