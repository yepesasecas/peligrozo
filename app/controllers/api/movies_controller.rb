module Api
  class MoviesController < ApplicationController
    before_filter :find_model

    def index
      json = {}
      movies = Movie.playing_now
      json[:movies] = movies.map{|m| {id: m.id, name: m.name, poster_path: m.poster_path} }
      render json: json, status: :ok
    end

    def show
      if @model
        json = {movies: @model}
        render json: json, status: :ok
      else
        head :not_found
      end
    end

    private
    def find_model
      @model = Movie.find(params[:id]) if params[:id]
    end
  end
end
