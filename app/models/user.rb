class User < ActiveRecord::Base
  has_paper_trail

  has_many :attendees, dependent: :destroy
  has_many :movie_nights_attending, through: :attendees, source: :movie_night
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
  has_many :friends, through: :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :user_movie_nights, foreign_key: "user_id", class_name: "MovieNight", dependent: :destroy
  has_many :movie_nights, -> { uniq }, through: :user_movie_nights, source: :movie

  has_many :movie_night_friends, dependent: :destroy

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

  public
    def facebook
      Facebook.new user: self
    end

    def friends_movie_nights
      movies = friends.map {|f| f.user_movie_nights}
      movies.flatten.uniq
    end

    def getmovies_by_friends
      uid_friend  = self.friendships.pluck :uid
      u_friend    = User.where(uid: uid_friend)
      u_friend_id = u_friend.pluck :id
      mn_id       = MovieNight.where(user_id: u_friend_id)
      movies_id   = mn_id.pluck :movie_id
      Movie.where(id: movies_id).all
    end


    # #<OmniAuth::AuthHash
    #   credentials=#<OmniAuth::AuthHash
    #       expires=true
    #       expires_at=1438362659
    #       token="CAANZAZBM0qzakBAAEm1K8MWxeU08oZCksbgZCP9TnYrOZCp3Gpl...">
    #     extra=#<OmniAuth::AuthHash
    #       raw_info=#<OmniAuth::AuthHash
    #       email="roanctf_sadanescu_1433174328@tfbnw.net"
    #       first_name="Bill"
    #       gender="male"
    #       id="104407753230963"
    #       last_name="Sadanescu"
    #       link="https://www.facebook.com/app_scoped_user_id/104407753230963/"
    #       locale="en_US" middle_name="Amihebaecefe" name="Bill Amihebaecefe Sadanescu"
    #       timezone=-5
    #       updated_time="2015-06-01T15:58:53+0000"
    #       verified=false>>
    #   info=#<OmniAuth::AuthHash::InfoHash
    #     email="roanctf_sadanescu_1433174328@tfbnw.net"
    #     first_name="Bill"
    #     image="http://graph.facebook.com/104407753230963/picture?type=square"
    #     last_name="Sadanescu"
    #     name="Bill Amihebaecefe Sadanescu"
    #     urls=#<OmniAuth::AuthHash
    #       Facebook="https://www.facebook.com/app_scoped_user_id/104407753230963/">
    #     verified=false>
    #   provider="facebook"
    #   uid="104407753230963">
    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.provider         = auth.provider
        user.uid              = auth.uid
        user.name             = auth.info.name
        user.email            = auth.info.email
        user.image            = auth.info.image
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
