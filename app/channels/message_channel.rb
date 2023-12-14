class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'message'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
    ActionCable.server.broadcast('message', data)
  end

end
