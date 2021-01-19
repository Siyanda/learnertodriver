if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/service-worker.js', { scope: './' })
  .then(function(reg) {
    console.log('[Companion]', 'Service worker registered!');
    console.log(reg);
  });
}
