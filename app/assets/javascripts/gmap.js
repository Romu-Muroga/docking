//初回読み込み、リロード、ページ切り替えで動く。
$(document).on('turbolinks:load', () => {
  var map;
  console.log("come")
  function initMap() {
    console.log("not come")
    if (!window.location.pathname.match(/\/posts\/\d+/)) return false
    var latlng = new google.maps.LatLng(-25.344, 131.036);
    var map = new google.maps.Map(document.getElementById('map'), {
      zoom: 4,
      center: latlng
    });
    var marker = new google.maps.Marker({
      position: latlng,
      map: map
    });
  }
  // HTMLの読み込みが完了してから実行
  window.onload = function () {
    initMap();
  }
});
