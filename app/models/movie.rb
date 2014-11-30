class Movie < ActiveRecord::Base
  include MovieDetails
  
  before_save :get_details, :titleize_name
 
  has_many :eliminated_movies, dependent: :destroy
  has_many :favorite_movies, dependent: :destroy
  has_many :genres, through: :movie_genres
  has_many :movie_genres, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :theaters, through: :schedules
  has_many :users, through: :favorite_movies
 
  scope :coming_soon, ->{ where(state: "coming_soon").order('created_at DESC') }
  scope :in_watchlist, ->{ where(state: [:coming_soon, :playing_now]).order('created_at ASC') }
  scope :last_day, ->{ where("created_at >= ?", 1.day.ago) }
  scope :last_week, ->{ where("created_at >= ?", 1.week.ago) }
  scope :not_in_tmdb, ->{ where(tmdb_id: nil).order('created_at DESC') }
  scope :playing_now, ->{ where(state: "playing_now").order('created_at DESC') }
  scope :remove, ->(movies_ids) { where.not(id: movies_ids) }
  scope :remove_tmdb, ->(tmdb_movies_ids) { where.not(tmdb_id: tmdb_movies_ids)}
  scope :with_no_trailer, ->{ where(trailer: nil).order('created_at DESC') }


  state_machine :state, initial: :coming_soon do
    event :playing do
      transition from: [:coming_soon, :not_show], to: :playing_now
    end
    event :take_out do
      transition from: :playing_now, to: :not_show
    end
  end

  def self.upcoming_for(user)
    upcomings = Fetch::Moviesdb.upcoming
    upcomings.map! do |upcoming|  
      Movie.new(name: upcoming["original_title"], 
                release_date: upcoming["release_date"], 
                poster_path: "http://image.tmdb.org/t/p/w154#{upcoming['poster_path']}", 
                tmdb_id: upcoming["id"] )
    end
    upcomings.select {|movie| not user.eliminated_tmdb_movies_ids.include?(movie.tmdb_id) }
  end

  def self.playing_now_for(user)
    self.playing_now
        .remove(user.movies.ids)
        .remove(user.eliminated_movies_ids)
        .remove_tmdb(user.eliminated_tmdb_movies_ids)
  end

  def stars_percentage
    (stars.to_f / 5 * 100).to_i
  end

  def stars
    favorite_movies.average(:stars).to_i
  end

  def details
    get_details
    self
  end

  def titleize_name
    self.name = name.titleize
  end

end
