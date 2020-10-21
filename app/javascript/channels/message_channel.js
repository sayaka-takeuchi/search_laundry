import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const tweetTime = moment(data.text.created_at).format('YYYY/MM/DD H:mm');
    const comment = data.text.text.replace(/\r?\n/g, '<br>');
    const html =  `<div class="comment">
                    <span> 投稿者:${data.name} ${tweetTime} </span>
                    <p>評価｜${data.rate}</p>
                    <p>${comment}</p>
                  </div>`;
    const messages = document.getElementById('comment-area');
    const newMessage = document.getElementById('comment_text');
    const age = document.getElementById('comment_age_id');
    const gender = document.getElementsByName('comment[gender]');
    const rate = document.getElementById('comment_rate_id');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value = '';
    age.selectedIndex = 0;
    rate.selectedIndex  = 0;
    gender.forEach(function(gender) {
      gender.checked = false;
    });
  }
});
