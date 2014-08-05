module Push
  def self.message(message)
    Pusher['admins'].trigger('my_event', {
      message: message
    })
  end
end