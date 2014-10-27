class Movie < ActiveRecord::Base
  include MovieDetails
  
  before_create :get_details
 
  has_many :schedules
  has_many :favorite_movies
  has_many :theaters, through: :schedules
  has_many :users, through: :favorite_movies


  # validates :tmdb_id, uniqueness: true  

  # default_scope { order('created_at DESC') }
  scope :playing_now,     ->{ where(state: "playing_now").order('created_at DESC') }
  scope :coming_soon,     ->{ where(state: "coming_soon").order('created_at DESC') }
  scope :in_watchlist,    ->{ where(state: [:coming_soon, :playing_now]).order('created_at ASC') }
  scope :not_in_tmdb,     ->{ where(tmdb_id: nil).order('created_at DESC') }
  scope :with_no_trailer, ->{ where(trailer: nil).order('created_at DESC') }

  state_machine :state, initial: :coming_soon do
    event :playing do
      transition from: [:coming_soon, :not_show], to: :playing_now
    end
    event :take_out do
      transition from: :playing_now, to: :not_show
    end
  end
  
  def self.upcoming
    upcomings = Fetch::Moviesdb.upcoming
    upcomings.map do |upcoming|
      Movie.new(name:         upcoming["original_title"], 
                release_date: upcoming["release_date"], 
                poster_path:  "http://image.tmdb.org/t/p/w154#{upcoming['poster_path']}", 
                tmdb_id:      upcoming["id"] )
    end
  end

  def details
    get_details
    self
  end

end
