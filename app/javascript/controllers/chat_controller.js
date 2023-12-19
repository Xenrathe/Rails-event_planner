import { Controller } from "@hotwired/stimulus"
import consumer from "channels/consumer"

export default class extends Controller {
  static targets = [ "chatbox", "textbox", "form" ]
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
                      <strong>${data.username}:</strong> ${data.body}
                  </div>`
        }
      });
    }
  }

  connect() {
    this.listen();
    this.scrollMessagesToBottom();
  }

  disconnect() {
    this.messageChannel.perform('unfollow')
  }

  listen() {
    if (this.messageChannel) {
      this.messageChannel.perform('follow', { message_id: this.data.get('id') } )
    }
  }

  submit(event) {
    event.preventDefault();
    this.formTarget.submit();
    this.textboxTarget.value = '';
  }

  scrollMessagesToBottom() {
    this.chatboxTarget.scrollTop = this.chatboxTarget.scrollHeight;

    // Wait for the messagesDiv to update before scrolling
    this.waitForMessagesToUpdate().then(() => {
      this.scrollMessagesToBottom();
    });
  }

  async waitForMessagesToUpdate() {
    return new Promise(resolve => {
      const observer = new MutationObserver(() => {
        // Check if the chatboxTarget (message list) content has changed
        if (this.chatboxTarget.scrollHeight > this.chatboxTarget.clientHeight) {
          observer.disconnect();
          resolve();
        }
      });

      // Observe changes to the chatboxTarget (message list) child nodes
      observer.observe(this.chatboxTarget, { childList: true, subtree: true });
    });
  }
}