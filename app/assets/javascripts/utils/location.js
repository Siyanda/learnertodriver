var options = {
  enableHighAccuracy: true,
  timeout: 5000,
  maximumAge: 0
};

function success(pos) {
  var crd = pos.coords;

  console.log('Your current position is:');
  console.log(`Latitude : ${crd.latitude}`);
  console.log(`Longitude: ${crd.longitude}`);
  console.log(`More or less ${crd.accuracy} meters.`);
}

function error(err) {
  console.warn(`ERROR(${err.code}): ${err.message}`);
}

// navigator.geolocation.getCurrentPosition(success, error, options);

// https://developer.mozilla.org/en-US/docs/Web/API/Geolocation/getCurrentPosition
// https://developers.google.com/web/fundamentals/codelabs/your-first-pwapp/
// https://www.creativebloq.com/features/9-amazing-pwa-secrets