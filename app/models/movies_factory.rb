class MoviesFactory
  def initialize(args)
  end

  def self.fetch(args={})
    p "fetchMovies.."
    #Guardar peliculas y teatros en la DB si no existen 
    peru_movies = fetch_movies(args[:perucom_div_position])
    theaters    = fetch_theaters
    #Agregar schedules, IF args["schedules"]
    if args[:schedules] == "true"
      Fetch::Perucom.create_schedules(peru_movies, theaters) 
    end
    # quitar peliculas de cartelera
    playing_now = Movie.playing_now
    not_showing = playing_now - peru_movies
    take_out_movies not_showing
    p "DONE"
  end

  def self.update_genres
    genres = Fetch::Moviesdb.genres
    genres.each do |new_genre|
      genre = Genre.find_by_tmdb_id(new_genre["id"])
      Genre.create(name: new_genre["name"], tmdb_id: new_genre["id"]) if genre.nil?
    end
  end

  def self.fetch_movies(perucom_div_position)
    movies       = Fetch::Perucom.get_movies(perucom_div_position)
    saved_movies = []
    movies.each do |nMovie|
      movie = Movie.find_by_name nMovie.name
      if movie.nil?
        nMovie.playing
        nMovie.save
        saved_movies.push nMovie
        p "new movie added"
      else
        movie.playing
        movie.update_attributes(value: nMovie.value)
        movie.save
        saved_movies.push movie
        p "movie exist #{movie.name}"
      end
    end
    saved_movies
  end

  def self.fetch_theaters
    theaters = Fetch::Perucom.get_theaters
    theaters_saved = []
    theaters.each do |nTheater|
      theater = Theater.find_by_name nTheater.name
      if theater.nil?
        nTheater.save
        theaters_saved.push nTheater
        p "new Theater added #{nTheater.id}"
      else
        theater.update_attributes(value: nTheater.value)
        theaters_saved.push theater
        p "theater exist #{theater.id}"
      end
    end
    theaters_saved
  end

  def self.take_out_movies(movies)
    p "taking out movies"
    
    movies.each do |movie|
      p "take out: #{movie.name}"
      movie.take_out
    end
  end
end