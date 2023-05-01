// Lazily loads elements with a data-src attribute. This is useful for speeding up initial page rendering.
document.addEventListener('turbo:load', () => {
  document.querySelectorAll('[data-src]').forEach((element) =>{
    element.setAttribute('src', element.getAttribute('data-src'))
  })
})
