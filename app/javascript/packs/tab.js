(()=> {
  // 変数名に＄をつけるとDOM要素を明示的に表す
    const $doc = document;
    const $tab = $doc.getElementById('js-tab');
    const $nav = $tab.querySelectorAll('[data-nav]');
    const $content = $tab.querySelectorAll('[data-content]');
    const ACTIVE_CLASS ='is-active';
    const navLen =$nav.length;
  
    // クリックしたら起こるイベント
    const handleClick = (e) => {
      e.preventDefault();
  
      // クリックされたnavとそのデータを取得
      const $this = e.target;
      const targetVal = $this.dataset.nav;
      
      // 対象外のnav, content全て一旦リセットする
      let index = 0;
      while(index < navLen){
        $content[index].style.display = 'none';
        $nav[index].classList.remove(ACTIVE_CLASS);
        index++;
      }
  
      // 対象のコンテンツをアクティブ化する
      $tab.querySelectorAll('[data-content="' + targetVal + '"]')[0].style.display = 'block';
      $nav[targetVal].classList.add(ACTIVE_CLASS);
    };
  
    // 全nav要素に対して関数を適応・発火
    let index = 0;
    while(index < navLen) {
      $nav[index].addEventListener('click', (e)=> handleClick(e));
      index++;
    }
  })();