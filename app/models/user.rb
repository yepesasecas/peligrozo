class User < ActiveRecord::Base
  public
  def friends_facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    @friends = @facebook.get_connections("me","friends")
  end

  def feed_facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
    #@friends = @facebook.put_connections("me", "feed", message: "Yo también estoy en PELIGROSO!"+ (rand(1..5)).to_s)    
    amigos = self.friendships.map { |i| i.uid}
    @friends = @facebook.put_connections("me", "feed", message: "Yo también estoy en PELIGROSO!"+ (rand(1..5)).to_s, place: '106339232734991', tags: amigos)
    
  end

  has_paper_trail

  has_many :countries, through: :country_users
  has_many :country_users
  has_many :eliminated_movies, dependent: :destroy
  has_many :favorite_genres, dependent: :destroy
  has_many :favorite_theaters, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy
  has_many :genres, through: :favorite_genres
  has_many :movies, -> { uniq }, through: :favorite_movies
  has_many :theaters, through: :favorite_theaters
  has_many :watchlist, foreign_key: "user_id", class_name: "FavoriteMovie"
  has_many :friendships, dependent: :destroy

  scope :in, -> (args) { joins(:country).where(countries: {code: args[:country_code]})}
  scope :playing_now, -> { where(state: "playing_now").order("created_at") }

  state_machine :state, initial: :at_genres do
    event :genres_done do
      transition from: :at_genres, to: :at_theaters
    end
    event :theaters_done do
      transition from: :at_theaters, to: :at_friends
    end
    event :friends_done do
      transition from: :at_friends, to: :config_done
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.email            = auth.info.email
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def eliminated_tmdb_movies_ids
    eliminated_movies.map { |e| e.tmdb_id }.compact
  end

  def favorite_theaters_by(args= {})
    movie_theaters = args[:movie].theaters
    self.theaters.select { |theater| movie_theaters.include? theater }
  end
end
