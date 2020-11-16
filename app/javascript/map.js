let map;
let mainMarker;
let marker = [];
let infoWindow = [];
let latLng;
let markerLatLng;

function initMap(){
  let markerData = gon.places;
  latLng = {lat: gon.latitude, lng: gon.longitude};
  // 初期位置の指定
  map = new google.maps.Map(document.getElementById('map'), {
  center: latLng,
  zoom: 14
  });

  // 初期位置にマーカーを立てる
  mainMarker = new google.maps.Marker({
    map: map,
    position: latLng
  });
  
    // 近隣店舗にマーカーを立てる
  for (var i = 0; i < markerData.length; i++) {
    const image = "https://maps.google.com/mapfiles/ms/icons/yellow-dot.png";
    const id = markerData[i]['id'];
    // 緯度経度のデータを作成
    markerLatLng = new google.maps.LatLng({lat: markerData[i]['latitude'], lng: markerData[i]['longitude']});
    // マーカーの追加
    marker[i] = new google.maps.Marker({
      position: markerLatLng,
      map: map,
      icon: image,
    });

    // 吹き出しの追加
    infoWindow[i] = new google.maps.InfoWindow({
      // 吹き出しに店舗詳細ページのリンクを追加
      content: `<a href=/laundries/${id}>${markerData[i]['name']}</a>
                <p>${markerData[i]['address']}</p>`
    });

    markerEvent(i);
  }

  // マーカークリック時に吹き出しを表示
  function markerEvent(i) {
    marker[i].addListener('click', function() {
      infoWindow[i].open(map, marker[i]);
    });
  }
}

document.addEventListener('turbolinks:load', function(){
  initMap();
});