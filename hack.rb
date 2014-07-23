require 'nokogiri'
require 'mechanize'
require 'open-uri'

# --------------------- VARIABLES -------------------------------------------------
movies   = []
theaters = []

# --------------------- CLASS -----------------------------------------------------
class Movie
  attr_accessor :name, :value, :theaters
  def initialize(args)
    @name     = args[:name]
    @value    = args[:value]
    @theaters = []
  end
end

class Theater
  attr_accessor :name, :value, :horario, :price, :address
  def initialize(args)
    @name    = args[:name]
    @value   = args[:value]
    @horario = args[:horario]
    @address = args[:address]
    @price   = args[:price]
  end
end

# --------------------- GET Movies and Theaters from peru.com --------------------
doc = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
p "loading movies and Theaters..."
doc.css('li.list-item').each do |li|
  name  = li.children.text
  value = li.attributes["data"].value.to_i

  if value > 500
    movie = Movie.new name: name, value: value
    movies.push movie
  else
    theater = Theater.new name: name, value: value
    theaters.push theater
  end
end
p "Done"

# --------------------- Get Horarios from peru.com form --------------------------
agent = Mechanize.new
page  = agent.get 'http://www.peru.com/entretenimiento/cine'

# movies = [movies.first]

p "loading Schedules for movies"
File.open("schedules.txt", "a+") do |file|
  movies.each do |movie|
    file.puts "========="
    file.puts movie.name
    theaters.each do |theater|
      form             = page.forms[1]
      form["pelicula"] = movie.value
      form["cine"]     = theater.value
      response         = agent.submit(form)
      noko             = Nokogiri::HTML(response.body)
      address          = noko.css('td.direccion').children.text
      price            = noko.css('td.precio').children.text
      schedules        = noko.css('td.horario').children.text
      movie.theaters.push Theater.new name: theater.name, value: theater.value, 
                                   horario: schedules, price: price, address: address
      file.puts "- #{theater.name} - #{price} - #{schedules}"
      p "#{movie.name} - #{theater.name}"
    end
  end
end