class Movie < ActiveRecord::Base
  before_create :get_details, :get_trailer
 
  has_many :schedules
  has_many :favorite_movies
  has_many :theaters, through: :schedules
  has_many :users, through: :favorite_movies

  scope :playing_now, ->{ where(state: "playing_now").order("created_at DESC") }
  scope :not_in_tmdb, ->{ where(tmdb_id: nil).order("created_at DESC") }

  state_machine :state, initial: :coming_soon do
    event :playing do
      transition from: :coming_soon, to: :playing_now
    end
    event :take_out do
      transition from: :playing_now, to: :not_show
    end
  end
  
  def self.upcoming
    upcomings = Fetch::Moviesdb.upcoming
    upcomings.map do |upcoming|
      Movie.new name: upcoming["original_title"], 
        release_date: upcoming["release_date"], 
         poster_path: upcoming["poster_path"], 
             tmdb_id: upcoming["tmdb_id"]
    end
  end

  private
  
    def get_details
      p "get_details"
      movie = Fetch::Moviesdb.search self.name
      if not movie.empty?
        details = Fetch::Moviesdb.detail movie.first.id
        self.overview     = details.overview if overview.nil?
        #self.poster_path  = details.poster_path if poster_path.nil?
        self.release_date = details.release_date 
        self.tmdb_id      = details.id
      end
    end

    def get_trailer
      p "get_trailer"
      trailers = Fetch::Moviesdb.trailers self.tmdb_id
      youtube  = trailers['youtube']
      if not youtube.nil?
        trailers = youtube.select {|video| video['type'] == 'Trailer'} 
        if trailers.empty?
          self.trailer = youtube[0]
        else
          self.trailer = trailers[0]["source"]
        end
      end
    end
end