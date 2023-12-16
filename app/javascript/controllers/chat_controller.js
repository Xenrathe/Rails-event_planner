import { Controller } from "@hotwired/stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "chatbox" ]
  initialize() {
    let chatController = this;
    let adventureElement = document.querySelector('#adventure-id');
    let adventureId = 0;

    if (adventureElement != null) {
      adventureId = document.querySelector('#adventure-id').value;
    }

    if (adventureId != 0 ) {
      this.messageChannel = consumer.subscriptions.create({channel: 'MessageChannel', room: adventureId}, {
        connected() {
          chatController.listen();
        },
    
        received(data) {
          chatController.chatboxTarget.insertAdjacentHTML('beforeend', this.template(data))
        },
    
        template(data) {
          return `<div class="message">
                      ${data.username}: ${data.body}
                  </div>`
        }
      });
    }
  }

  connect() {
    this.listen()
  }

  disconnect() {
    this.messageChannel.perform('unfollow')
  }

  listen() {
    if (this.messageChannel) {
      this.messageChannel.perform('follow', { message_id: this.data.get('id') } )
    }
  }
}