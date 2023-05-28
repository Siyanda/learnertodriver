import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

 static values = {
                   state: { type: String, default: 'start' },
                   index: { type: Number, default: 0 }
                  }

  static targets = [ 'slide', 'progress', 'controls' ]

  initialize() {
    console.log('load quiz')
  }

  indexValueChanged() {
    this.currentSlide()
    this.sliderState()
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
    let position = this.indexValue
    let max = parseInt(this.slideTargets.length - 1)

    position <= 0 ? this.stateValue = 'start' :
    position >= max ? this.stateValue = 'end' : this.stateValue = 'in_progress'
  }
}
