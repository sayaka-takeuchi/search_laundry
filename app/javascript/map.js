function initMap(){
  let latlng = {lat: 34.741020, lng: 137.385869};
  let map = new google.maps.Map(document.getElementById('map'), {
  center: latlng,
  zoom: 13
  });
  let marker = new google.maps.Marker({
    map: map,
    position: latlng
  });
}
  

document.addEventListener('turbolinks:load', function(){
  initMap();
});