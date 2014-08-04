require 'open-uri'
require 'nokogiri'
require 'mechanize'


p "fetchMovies.."

movies = Fetch::Perucom.get_movies
movies.each {|movie| movie.save}

theaters = Fetch::Perucom.get_theaters
theaters.each {|theater| theater.save}

Fetch::Perucom.create_schedules(movies, theaters)

p "FetchMovies.. DONE"