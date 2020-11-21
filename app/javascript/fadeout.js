function fadeOut() {
  const $flashMsg = document.querySelector('.flash-message');
  
  // 表示されてから2秒後にフェードアウトを開始する。
  const TIMEOUT_DELAY = 2000;
  
  // 20ミリ秒に一回, opacityの値を0.01減少させる設定
  const INTERVAL_DELAY = 20;
  const OPACITY_VAL = 0.01;
  
  // flashメッセージを消す処理
  const deleteFlashMessage = () => {
    const id = setInterval(() => {
      const opacity = $flashMsg.style.opacity;
      
      if(opacity > 0) {
        $flashMsg.style.opacity = opacity - OPACITY_VAL;
      } else {
        // opacityが０になったら繰り返し動作をキャンセルする。
        clearInterval(id);
      }
    }, INTERVAL_DELAY);
  };
  
  if($flashMsg != null) {
    // flashメッセージが存在する場合、プロパティ(opacity)を追加する
    $flashMsg.style.opacity = 1
    setTimeout(deleteFlashMessage, TIMEOUT_DELAY);
  }
};

window.onload = fadeOut;