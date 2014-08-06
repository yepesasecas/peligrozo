class Movie < ActiveRecord::Base
  before_create :get_details, :get_trailer

  has_many :schedules
  has_many :theaters, through: :schedules

  scope :playing_now, ->{ where "state = 'playing_now'" }
  scope :upcoming, ->{ Fetch::Moviesdb.upcoming }

  state_machine :state, initial: :coming_soon do
    event :playing do
      transition from: :coming_soon, to: :playing_now
    end
    event :take_out do
      transition from: :coming_soon, to: :not_show
    end
  end

  private
    def get_details
      p "get_details"
      movie = Fetch::Moviesdb.search self.name
      if not movie.empty?
        details = Fetch::Moviesdb.detail movie.first.id
        self.overview     = details.overview if overview.nil?
        self.poster_path  = details.poster_path if poster_path.nil?
        self.release_date = details.release_date 
        self.tmdb_id      = details.id
      end
    end

    def get_trailer
      p "get_trailer"
      trailers = Fetch::Moviesdb.trailers self.tmdb_id
      youtube  = trailers['youtube']
      if not youtube.nil?
        trailers = youtube.select {|video| video['type']=='Trailer'} 
        if trailers.empty?
          self.trailer = youtube[0]
        else
          self.trailer = trailers[0]["source"]
        end
      end
    end
end
