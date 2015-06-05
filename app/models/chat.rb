class Chat < ActiveRecord::Base
  belongs_to :movie_night

  public
    def add_message(args)
      self.conversation = eval(conversation).push({
        owner: args[:owner],
        conversation: args[:conversation]
      }).to_s
      save
    end

    def messages
      eval(conversation)
    end
end
