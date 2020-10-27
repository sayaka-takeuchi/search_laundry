document.getElementById("info-btn").onclick = function(){
  const loginInfo = document.getElementById("js-login-info");
  if(loginInfo.style.display=="block"){
    loginInfo.style.display = "none";
  }else{
    loginInfo.style.display = "block";
  }
};