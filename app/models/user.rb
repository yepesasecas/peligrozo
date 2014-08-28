class User < ActiveRecord::Base
  has_many :favorite_genres, dependent: :destroy
  has_many :favorite_theaters, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy
  has_many :genres, through: :favorite_genres
  has_many :theaters, through: :favorite_theaters
  has_many :movies, -> { uniq }, through: :favorite_movies
  has_many :watchlist, foreign_key: "user_id", class_name: "FavoriteMovie"

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
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider         = auth.provider
      user.uid              = auth.uid
      user.name             = auth.info.name
      user.oauth_token      = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def find_favorite_theaters movie
    favorite_theaters = self.theaters
    movie_theaters    = movie.theaters
    theaters          = []
    favorite_theaters.each do |favorite_theater|
      theaters.push favorite_theater if movie_theaters.include? favorite_theater
    end
    theaters
  end
end
