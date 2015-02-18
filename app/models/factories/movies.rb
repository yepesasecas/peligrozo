module Factories
  class Movies

    def self.update(args={})
      sources = Sources::Manager.fetch_movies(args)
      self.update_sources(sources)
    end

    def self.update_with_schedules_in_production
      self.update(schedules: true, production: true)
    end

    def self.update_with_schedules_in_development
      self.update(schedules: true, production: false)
    end

    def self.update_in_production
      self.update(production: true)
    end

    def self.update_in_development
      self.update(production: false)
    end

    private
    def self.update_sources(sources)
      sources.each do |source| 
        self.update_theaters(source[:data][:theaters])
        self.update_movies(source[:data][:movies])
      end
    end

    def self.update_movies(movies)
      new_movies = []
      movies.each do |n_movie|
        movie = self.find_or_create_movie(n_movie)
        movie.update value: n_movie[:value]
        movie.save
        movie.update_genres
        movie.playing
        new_movies.push(movie)
        if n_movie[:schedules]
          self.update_movie_schedules(movie: movie,schedules: n_movie[:schedules])
        end
      end
      self.remove_old_movies(new_movies)
    end

    def self.update_theaters(theaters)
      Factories::Theaters.new(theaters: theaters).update
    end

    def self.remove_old_movies(new_movies)
      remove = Movie.playing_now - new_movies
      remove.each { |movie| movie.take_out }
    end

    def self.find_or_create_movie(n_movie)
      Movie.find_by(name: n_movie[:name]) ||
        Movie.create(name: n_movie[:name],
                     value: n_movie[:value],
                     overview: n_movie[:overview],
                     poster_path: n_movie[:poster_path])
    end

    def self.update_movie_schedules(args)
      Factories::Schedules.new(args).update
    end
  end
end
