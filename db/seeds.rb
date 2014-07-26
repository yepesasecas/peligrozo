require 'open-uri'

movies   = []
theaters = []
doc      = Nokogiri::HTML(open('http://www.peru.com/entretenimiento/cine'))

p "-------------------"
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

# --------------------- Get POster Path --------------------------
p "-------------------"
p "get Poster path "
div_listados = doc.css("div.listado_peliculas")
div_listados.each do |div_listado|
  ul_div = div_listado.children[1]
  ul_div.children.each do |li|
    if li.class == Nokogiri::XML::Element
      figure_div     = li.children[1]
      a_div          = figure_div.children[1]
      img_div        = a_div.children[1]
      img_attributes = img_div.attributes
      poster_movie   = img_attributes["alt"].value
      poster_path    = img_attributes["data-original"].value

      movie = Movie.find_by_name poster_movie
      if(movie)
        movie.update_attributes poster_path: poster_path
      end
      p poster_path
    end
  end
end
# --------------------- Get Horarios from peru.com form --------------------------
agent = Mechanize.new
page  = agent.get 'http://www.peru.com/entretenimiento/cine'

# movies   = [movies.first]
theaters = [theaters.first]

p "-------------------"
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
    movie.update_attributes overview: overview
    p "#{movie.name} - #{theater.name}"
  end
end
