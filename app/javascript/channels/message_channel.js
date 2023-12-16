import consumer from "./consumer"
//NOTE: MOVED THIS OVER TO A STIMULUS CONTROLLER (chat_controller.js)
/* 
console.log("message_channel is called");
let adventureElement = document.querySelector('#adventure-id');
let adventureId = 0;

if (adventureElement != null) {
  adventureId = document.querySelector('#adventure-id').value;
  console.log("ADVENTURE ID IS " + adventureId)
}

if (adventureId != 0 ) {
  consumer.subscriptions.create({channel: 'MessageChannel', room: adventureId}, {
    connected() {
      console.log("CONNECTED");
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
}*/
