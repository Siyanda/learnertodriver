import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['option','icon'];

  toggle(event) {
    this.optionTarget.classList.toggle('active');
    this.iconTarget.classList.toggle('active');
  }
}