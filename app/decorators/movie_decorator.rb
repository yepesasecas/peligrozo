class MovieDecorator
  attr_reader :movie, :user
  
  include ActionView::Helpers::TagHelper

  def self.build_with(array)
    array.map{ |movie| MovieDecorator.new(movie) }
  end

  def initialize(movie, user = nil )
    @movie = movie
    @user  = user
  end

  def id
    movie.id
  end

  def name
    movie.name
  end

  def playing_now?
    @playing_now ||= movie.playing_now?
  end

  def theaters
    @theaters ||= movie.theaters
  end

  def schedules
    @schedules ||= movie.schedules
  end

  def created_at
    @created_at ||= movie.created_at
  end

  def tmdb_id
    @tmdb_id ||= movie.tmdb_id
  end

  def release_date
    @release_date ||= movie.release_date
  end

  def stars
    @stars ||= movie.stars
  end

  def stars_percentage
    @stars_percentage ||= "#{movie.stars_percentage} %"
  end

  def stars_present?
    if stars > 0
      true
    else
      false
    end  
  end

  def stars_image
    case movie.stars
    when 0..1.666 then "stars/1-white.png"
    when 1.667..3.332 then "stars/3-white.png"
    when 3.332..5 then "stars/5-white.png"
    end
  end

  def distance_of_time_to_release_date
    days_to_release_date.abs
  end

  def days_to_release_date
    release = release_date.presence || created_at.to_date || 9999
    (release - Date.current).to_i
  end

  def coming_soon?
    movie.coming_soon?
  end

  def trailer?
    movie.trailer?
  end

  def trailer
    movie.trailer
  end

  def youtube
    "http://www.youtube.com/embed/#{movie.trailer}"
  end

  def poster_path
    movie.poster_path
  end

  def overview
    if movie.overview.present?
      movie.overview
    else
      "La pelicula todavia no cuenta con una descripción."
    end
  end

  def overview_class
    "alert" unless movie.overview.present?
  end

  def favorite_theaters
    @favorite_theaters ||= user.favorite_theaters_by(movie: movie)
  end

  def first_schedule
    if favorite_theaters.empty?
      schedules.find_by(theater_id: theaters.first.id)
    else
      schedules.find_by(theater_id: favorite_theaters.first.id)
    end
  end
  
  def in_watchlist?
    @in_watchlist ||= user.movies.include?(movie)   
  end 

  def add_or_update_watchlist
    user.favorite_movies.find_by(movie_id: movie.id).presence || user.favorite_movies.new
  end

  def add_or_update_seen_movies
    user.favorite_movies.find_by(movie_id: movie.id)
  end

  def watchlist_id
    if in_watchlist?
      "button_delete_watchlist"
    else
      "button_add_watchlist"
    end
  end

  def watchlist_image
    if in_watchlist?
      "boton_remove_from_watchlist.png"
    else
      "boton_watchlist.png"
    end
  end

  def label_class
    if movie.playing_now?
      "cartelera-date"
    elsif movie.coming_soon?
      "upcoming-date"
    end 
  end

  def favorite_theaters_to_show
    favorite_theaters.map { |theater| [theater.name, theater.id] }
  end

  def all_theaters_to_show
    theaters.map { |theater| [theater.name, theater.id] }
  end

end
