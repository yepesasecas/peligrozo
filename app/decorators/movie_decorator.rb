class MovieDecorator
  attr_reader :movie

  def initialize(movie)
    @movie = movie
  end

  def id
    movie.id
  end

  def name
    movie.name
  end

  def theaters
    movie.theaters
  end

  def schedules
    movie.schedules
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

end
