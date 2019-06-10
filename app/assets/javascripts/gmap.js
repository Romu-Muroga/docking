// ターボリンクのロードが終わってから発動する
$(document).on('turbolinks:load', () => {
  var map;
  function initMap() {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {lat: -34.397, lng: 150.644},
      zoom: 8
    });
  }
});//で囲うとgoogle mapが表示されない
