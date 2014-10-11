module MovieDetails
  extend ActiveSupport::Concerns

  private

    def get_details
      get_tmdb_id_by_name if tmdb_id.nil?
      if tmdb_id.present?
        get_details_by_id
        get_trailer
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

      self.overview     = response.overview if overview.nil?
      self.poster_path  = response.poster_path if poster_path.nil?
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