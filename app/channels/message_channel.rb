class MessageChannel < ApplicationCable::Channel
  def subscribed
    @adventure = Adventure.find(params[:room])

    if allowed_to_subscribe?
      stream_for @adventure
    else
      puts "Rejecting connection"
      reject_unauthorized_connection
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    adventure = Adventure.find(params[:room])
    MessageChannel.broadcast_to(adventure, data)
  end

  private

  def allowed_to_subscribe?
    @adventure.creator_id == current_user.id || Adventure.attending(current_user).exists?(@adventure.id)
  end

end
