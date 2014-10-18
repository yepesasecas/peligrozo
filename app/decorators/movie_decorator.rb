class MovieDecorator
  attr_reader :movie, :user

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

  def theaters
    @theaters ||= movie.theaters
  end

  def schedules
    @schedules ||= movie.schedules
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
end
