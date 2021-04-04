import { Controller } from 'stimulus'

export default class extends Controller {

  // static targets = ['menu'];

  static get targets() {
    return ['menu']
  }

  toggle(event) {
    this.menuTarget.classList.toggle('active');
  }
}
