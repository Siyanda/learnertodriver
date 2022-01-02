import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static values = { index:Number };

  static get targets() {
    return ['slide', 'progress', 'counter']
  }

  connect() {
    this.activeSlide();
  }

  show(slide) {
    return slide.style.display = 'flex';
  }

  hide(slide) {
    return slide.style.display = 'none';
  }

  next() {
    this.indexValue++
    this.activeSlide();
  }

  previous() {
    this.indexValue--
    this.activeSlide();
  }

  hideAllSlides() {
    this.slideTargets.map(this.hide);
  }

  progressUpdate() {
  }

  activeSlide() {
    const currentIndex = parseInt(this.indexValue);
    const currentSlide = this.slideTargets[currentIndex];

    this.hideAllSlides();
    this.show(currentSlide);
  }
}