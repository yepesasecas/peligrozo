class Facebook
  attr_reader :user, :user_api

  def initialize(args)
    @user     = args[:user]
    @user_api = Facebook.api(token: user.oauth_token)
  end

  public
    def me
      user_api.get_object 'me'
    end

    def friends
      user_api.get_connections("me", "friends")
    end

    def feed
      amigos = self.friendships.map {|i| i.uid}
      @friends = user_api.put_connections("me", "feed", message: "Yo también estoy en PELIGROSO!"+ (rand(1..5)).to_s, place: '106339232734991', tags: amigos)
    end

    def self.api(args)
      Koala::Facebook::API.new(args[:token])
    end
end
