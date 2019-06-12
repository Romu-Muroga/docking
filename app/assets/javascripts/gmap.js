// ターボリンクのロードが終わってから発動する
$(document).on('turbolinks:load', () => {
  var map;
  function initMap() {
    // The location of Uluru
    var uluru = {lat: -25.344, lng: 131.036};
    // The map, centered at Uluru
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4, center: uluru
    });
    // The marker, positioned at Uluru
    var marker = new google.maps.Marker({position: uluru, map: map});
  }
  // InvalidValueError: initMap is not a functionの対応
  window.onload = function () {
    initMap();
  }
});//で囲うとgoogle mapが表示されない
