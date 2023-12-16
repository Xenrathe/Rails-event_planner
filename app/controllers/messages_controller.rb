class MessagesController < ApplicationController

  def create

    # User must be logged in
    return unless current_user

    # User must be involved in the adventure (creator or attendee)
    @adventure = Adventure.find(params[:adventure_id])
    @attended_adventures = Adventure.attending(current_user)
    return unless @adventure.creator_id == current_user.id || @attended_adventures.exists?(@adventure.id)
    
    @message = @adventure.messages.build(message_params)
    @message.username = current_user.username
  
    if @message.save
      puts "Message is saved."
      MessageChannel.broadcast_to(@adventure, @message)
    else
      puts "Message couldn't be saved. Errors: #{@message.errors.full_messages.join(', ')}"
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :adventure_id)
  end
end
