document.addEventListener("turbolinks:load", function() {

var idbSupported = false;

document.addEventListener("DOMContentLoaded", function(){

  if("indexedDB" in window) {
      idbSupported = true;
  }

},false);

})
;