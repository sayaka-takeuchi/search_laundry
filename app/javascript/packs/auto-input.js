  document.getElementById("js-time-btn").onclick = function(){
  const openingHour = document.querySelectorAll(".opening-hour");
  openingHour.forEach((time)=>{
    time.value = "00"
  })
}
