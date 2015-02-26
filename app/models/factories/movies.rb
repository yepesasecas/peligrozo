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
        country = self.find_country_by code: source[:country_code]
        raise "country doesnt exist!" if country.nil?
        
        self.update_theaters(theaters: source[:data][:theaters],  country: country)
        self.update_movies(movies: source[:data][:movies], country: country)
      end
    end

    def self.update_movies(args)
      new_movies = []
      movies = args[:movies]

      movies.each do |n_movie|
        movie = self.find_or_create_movie(n_movie)
        movie.update value: n_movie[:value]
        movie.save
        movie.country = args[:country]
        movie.update_genres
        movie.playing
        new_movies.push(movie)
        if n_movie[:schedules]
          self.update_movie_schedules(movie: movie,schedules: n_movie[:schedules])
        end
      end
      self.remove_old_movies(new_movies)
    end

    def self.update_theaters(args={})
      Factories::Theaters.new(args).update
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

    def self.find_country_by(args={})
      Country.find_by code: args[:code]
    end
  end
end
