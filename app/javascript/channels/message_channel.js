import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const now = new Date();
    const year = now.getFullYear();
    const month = now.getMonth();
    const date = now.getDate();
    const hour = now.getHours();
    const min = now.getMinutes();
    const sendTime = `${year}/${month + 1}/${date} ${hour}:${min}`
    const comment = data.text.text.replace(/\r?\n/g, '<br>');
    const form = document.getElementById('js-form');
    const messages = document.getElementById('comment-area');
    const html =  `<div class="comment">
                    <a data-confirm="削除しますか？" data-remote="true" rel="nofollow" data-method="delete" href="/laundries/${data.text.laundry_id}/comments/${data.text.id}">
                      <img class="delete-btn" src="/assets/delete-b0e544f038027f879110c01a37711b944849121f7f3c744257be0fae6bc8229e.png">
                    </a>
                    <span> 投稿者:${data.name} ${sendTime} </span>
                    <p>評価｜${data.rate}</p>
                    <p>${comment}</p>
                  </div>`;
    messages.insertAdjacentHTML('afterbegin', html);
    form.reset();
  }
});
