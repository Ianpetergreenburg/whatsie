class RandomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "random_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
