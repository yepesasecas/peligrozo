module Fetch
  module Tmdb
    def self.ini
      Tmdb::Api.key("999e1362be6ce13ac10a05a8122ca9ae")
      Tmdb::Api.language("es")
    end
  end
end