require 'open-uri'

movies   = []
theaters = []

doc = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
p "loading movies and Theaters..."
doc.css('li.list-item').each do |li|
  name  = li.children.text
  value = li.attributes["data"].value.to_i

  if value > 500
    movie = Movie.create name: name, value: value
    movies.push movie
  else
    # theater = Theater.create name: name, value: value
    # theaters.push theater
  end
end
p "Done"

