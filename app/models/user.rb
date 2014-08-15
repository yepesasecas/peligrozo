class User < ActiveRecord::Base
  has_many :favorite_genres
  has_many :favorite_theaters
  has_many :genres,   through: :favorite_genres
  has_many :theaters, through: :favorite_theaters
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
    favorite_theaters.each do | favorite_theater|
      theaters.push favorite_theater if movie_theaters.include? favorite_theater
    end
    theaters
  end
end
