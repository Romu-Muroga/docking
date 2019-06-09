// $(document).on("turbolinks:load", () => {});で囲うとエラーが出る
var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8
  });
}
