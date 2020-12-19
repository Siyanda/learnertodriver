document.addEventListener("turbolinks:load", function() {

  let floatContainer = document.getElementsByClassName("rounded_number")

  if (floatContainer.length > 0) {

    let allFloats = Array.from(floatContainer);

      allFloats.forEach(function(element) {

        let floatText = parseFloat(element.innerHTML)
        let formatedFloat = floatText.toPrecision(2)

        element.innerHTML = formatedFloat;

      })
    ;

  }
})
;
