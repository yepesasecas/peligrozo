class MoviesFactory
  def initialize(args)
    
  end
  
  def self.fetch
    movies   = fetch_movies
    theaters = fetch_theaters
  end

  def self.fetch_movies
    movies = Fetch::Perucom.get_movies
    movies.each do |nMovie|
      movie = Movie.find_by_name nMovie.name
      if movie.nil?
        nMovie.save
        p "new movie added"
      else
        p "movie exist #{movie.name}"
      end
    end
    movies
  end

  def self.fetch_theaters
    theaters = Fetch::Perucom.get_theaters
    theaters.each do |nTheater|
      theater = Theater.find_by_name nTheater.name
      if theater.nil?
        nTheater.save
        p "new Theater added"
      else
        p "theater exist #{theater.name}"
      end
    end
    theater
  end
end