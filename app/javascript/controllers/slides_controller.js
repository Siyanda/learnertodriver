import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static values = { index:Number }

  static get targets() {
    return [  'slide',
              'progress',
              'hideStart',
              'hideEnd',
              'hideDuring',
              'showStart',
              'showDuring',
              'showEnd']
  }

  initialize() {
  }

  connect() {
    this.activeSlide()
    this.hideStart()
    this.showEndTargets.map(this.hide)
  }

  show(slide) {
    return slide.style.display = 'flex'
  }

  hide(slide) {
    return slide.style.display = 'none'
  }

  next() {
    this.indexValue++
    this.activeSlide()
    this.hideStartTargets.map(this.show)
  }

  previous() {
    this.indexValue--
    this.activeSlide()
  }

  showDuring() {
    this.showDuringTargets.map(this.show)
  }

  hideStart() {
    this.hideStartTargets.map(this.hide)
  }

  hideAllSlides() {
    this.slideTargets.map(this.hide)
  }

  showAllSlides() {
    this.slideTargets.map(this.show)
  }

   controlVisibility() {
  }

  progressUpdate(start) {
    // const currentProgress = this.indexValue + parseInt(start)
    // this.progressTarget.max = this.slideTargets.length
    // this.progressTarget.value = currentProgress
  }

  activeSlide() {
    const currentIndex = parseInt(this.indexValue)
    const currentSlide = this.slideTargets[currentIndex]

    this.hideAllSlides()
    this.show(currentSlide)
    this.progressUpdate(1)
    this.showDuring()
  }

  disconnect() {
  }
}
