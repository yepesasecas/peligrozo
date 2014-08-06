class Push
  def initialize(args={})
    
  end
  
  def message(message)
    Pusher['admins'].trigger('my_event', {
      message: message
    })
  end
end