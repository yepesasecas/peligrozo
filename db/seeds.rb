require 'open-uri'

movies   = []
theaters = []

doc = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))
p "loading movies and Theaters..."
doc.css('li.list-item').each do |li|
  name  = li.children.text
  value = li.attributes["data"].value.to_i

  if 500 < value
    movie = Movie.create name: name, value: value
    movies.push movie
  else
    theater = Theater.create name: name, value: value
    theaters.push theater
  end
end
p "Done"
# --------------------- Get Horarios from peru.com form --------------------------

# listado      = doc.css('div.destaques.listado_peliculas').children.children
# poster       = listado[1].children[1].children[1].children[1]
# poster_movie = poster.attributes["alt"].value
# poster_path  = poster.attributes["src"].value
# p poster_movie
# p poster_path



# --------------------- Get Horarios from peru.com form --------------------------
agent = Mechanize.new
page  = agent.get 'http://www.peru.com/entretenimiento/cine'

# movies   = [movies.first]
theaters = [theaters.first]

p "loading Schedules for movies"
movies.each do |movie|
  theaters.each do |theater|
    form             = page.forms[1]
    form["pelicula"] = movie.value
    form["cine"]     = theater.value
    response         = agent.submit(form)
    noko             = Nokogiri::HTML(response.body)
    address          = noko.css('td.direccion').children.text
    price            = noko.css('td.precio').children.text
    schedules        = noko.css('td.horario').children.text
    overview         = noko.css('p')[2].children.text
    p overview
    movie.update_attributes overview: overview
    p "#{movie.name} - #{theater.name}"
  end
end
