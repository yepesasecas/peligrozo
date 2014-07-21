class LandingController < ApplicationController

  def index
    Tmdb::Api.key("999e1362be6ce13ac10a05a8122ca9ae")
    Tmdb::Api.language("es")

    @now_playing = Tmdb::Movie.now_playing
    @upcoming    = Tmdb::Movie.upcoming 
  end
end
