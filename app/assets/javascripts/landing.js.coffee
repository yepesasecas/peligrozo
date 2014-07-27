Modal = 
  title: (title) -> $(".movie-details").find(".modal-title").html(title)
  
  overview: (overview) -> $(".movie-details").find(".modal-body").find(".modal-overview").html(overview)
  
  theaters: (theaters, movie_id) -> 
    select = $(".movie-details").find(".modal-body").find(".select-movie-theater")
    select.append("<option value=" + theater.id + ">" + theater.name + "</option>") for theater in theaters
    select.data("movie", movie_id)
    console.log movie_id
  
  schedule: (description)-> $(".movie-details").find(".modal-body").find(".modal-schedules").html(description)


Movies =
  getSchedule: (movie_id, theater_id)->
    console.log movie_id + " " + theater_id
    url = "/movies/" + movie_id + "/theaters/" + theater_id
    $.getJSON url, (response)->
      Modal.schedule(response[0].description)

  get: (id) =>
    url = "/movies/" + id
    $.getJSON url, (response)->
      movie    = response.movie
      theaters = response.theaters
      Modal.title(movie.name)
      Modal.overview(movie.overview)
      Modal.theaters(theaters, movie.id)
      $('.movie-details').modal('show')
      @getSchedule(theaters[0].id, movie.id)


$(document).ready ->
  $('.movie-poster').on 'click', (e) ->
    e.preventDefault()
    movie_id = $(this).data("movie")
    movie = Movies.get movie_id

  $('select.select-movie-theater').on 'change', -> 
    theater = $(this)
    Movies.getSchedule(theater.data("movie"), theater.val())