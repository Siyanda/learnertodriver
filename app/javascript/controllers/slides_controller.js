import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static get targets() {
    return ['slide']
  }

  connect(){

  }

  next(){
    if(this.indexValue < (this.slideTargets.length - 1)){
      this.indexValue++;
    }else{
      this.indexValue = 0;
    }
  }

  previous(){
    if(this.indexValue > 0){
      this.indexValue--;
    }else{
      this.indexValue = this.slideTargets.length - 1;
    }
   }

  stopSlideShow(){
    if(this.slideShowTimer){
      clearInterval(this.slideShowTimer);
    }
  }

  disconnect(){
    this.stopSlideShow();
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      //element.hidden = index != this.indexValue;
      var isHidden = index != this.indexValue;
      if(isHidden){
        element.classList.remove('active');
      }else{
        element.classList.add('active');
      }
    })
   }

}