module MovieDetails
  extend ActiveSupport::Concerns

  def update_genres
    return unless tmdb_id.present?

    genres = Fetch::Moviesdb.detail(tmdb_id).genres
    genres.each do |genre|
      self.movie_genres.create(genre: Genre.find_by(tmdb_id: genre["id"]))
    end
  end

  private

    def get_details

      if tmdb_id.nil?
        get_tmdb_id_by_name 
      end

      if tmdb_id.present?
        get_details_by_id
        get_trailer unless trailer.present?
      end
    end

    def get_tmdb_id_by_name
      response = Fetch::Moviesdb.search name
      
      unless response.empty?
        self.tmdb_id = response.first.id
      end
    end

    def get_details_by_id
      response = Fetch::Moviesdb.detail tmdb_id
      
      self.name         = response.title || response.original_title if name.nil?
      self.overview     = response.overview if overview.nil?
      self.poster_path  = "http://image.tmdb.org/t/p/w154#{response.poster_path}" if poster_path.nil?
      self.release_date = response.release_date
    end

    def get_trailer
      trailers = Fetch::Moviesdb.trailers tmdb_id
      youtube  = trailers['youtube']

      unless youtube.nil?
        trailers = youtube.select {|video| video['type'] == 'Trailer'} 
        if trailers.empty?
          self.trailer = youtube[0]
        else
          self.trailer = trailers[0]["source"]
        end
      end
    end

end