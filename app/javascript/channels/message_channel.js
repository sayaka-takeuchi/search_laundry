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
    const html = `<div class= "comment">
                    <p>${data.text.text}</p>
                    <span class="contributor">by ${data.name}</span>
                    <span class="contributor">at :${tweetTime}</span>
                  </div>`;
    const messages = document.getElementById('comment-area')
    const newMessage = document.getElementById('comment_text')
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value = '';
  }
});
