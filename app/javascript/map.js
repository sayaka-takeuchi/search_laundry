function initMap(){
  let latlng = {lat: gon.latitude, lng: gon.longitude};
  let map = new google.maps.Map(document.getElementById('map'), {
  center: latlng,
  zoom: 15
  });
  let marker = new google.maps.Marker({
    map: map,
    position: latlng
  });
}
  

document.addEventListener('turbolinks:load', function(){
  initMap();
});