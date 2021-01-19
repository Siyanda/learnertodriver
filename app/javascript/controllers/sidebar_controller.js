import { Controller } from 'stimulus'

export default class extends Controller {

  static targets = ['logo','icon','wrapper','bar'];

  toggle(event) {
    this.iconTarget.classList.toggle('hidden');
    this.logoTarget.classList.toggle('hidden');

    this.wrapperTarget.classList.toggle('right-side');
    this.barTarget.classList.toggle('hidden');
  }
}
