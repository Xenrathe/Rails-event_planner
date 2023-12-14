class MessagesController < ApplicationController

  def create
    @adventure = Adventure.find(params[:adventure_id])
    @message = @adventure.messages.build(message_params)
    @message.username = current_user.username
  
    if @message.save
      puts "Message is saved."
      ActionCable.server.broadcast('message', @message.as_json)
    else
      puts "Message couldn't be saved. Errors: #{@message.errors.full_messages.join(', ')}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
