import consumer from "channels/consumer"

const messageChannel = consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messageDisplay = document.querySelector('#message-display')
    messageDisplay.insertAdjacentHTML('beforeend', this.template(data))
  },

  template(data) {
    return `<div class="message">
                ${data.username}: ${data.body}
            </div>`
  }
});
