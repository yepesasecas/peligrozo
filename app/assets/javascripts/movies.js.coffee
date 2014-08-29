
Modal = 
  show: ->  
    $('.movie-details').modal('show')
  title: (title) -> 
    $(".movie-details").find(".modal-title").html(title)
  poster: (poster_path) ->
    $(".movie-details").find(".modal-poster-img").html("<img alt='Logo' id='logo' class='poster-modal hidden-xs' src=" + poster_path + ">")
  overview: (overview) -> 
    $(".movie-details").find(".modal-body").find(".modal-overview").html(overview)
  theaters: (theaters, favorite_theaters, movie_id) -> 
    select = $(".movie-details").find(".modal-body").find(".select-movie-theater")
    select.html("")
    console.log favorite_theaters
    if favorite_theaters.length > 0
      select.append("<option disabled>Tus cines Favoritos</option>") 
      select.append("<option value=" + theater.id + ">" + theater.name + "</option>") for theater in favorite_theaters
      select.append("<option disabled>Todos los cines</option>") 
    select.append("<option value=" + theater.id + ">" + theater.name + "</option>") for theater in theaters
    select.data("movie", movie_id)
  schedule: (description)-> 
    $(".movie-details").find(".modal-body").find(".modal-schedules").html(description)
  trailer: (id)->
    $(".btn-trailer-play").show()
    $(".movie-details").find(".modal-body").find(".modal-trailer").html("<iframe width='598' height='419' src=http://www.youtube.com/embed/" + id + " frameborder='0' allowfullscreen></iframe>")
  clean: ->
    $(".btn-trailer-play").hide()
    $(".movie-details").find(".modal-body").find(".modal-trailer").html("")
  show_trailer: ->
    $('.modal-row-trailer').show()
    $('.modal-row-details').hide()
    $('.boton_back_video').show()
  show_details: ->
    $('.modal-row-trailer').hide()
    $('.modal-row-details').show()
    $('.boton_back_video').hide()
  hide_trailer: ->

Movies =
  getSchedule: (movie_id, theater_id)->
    url = "/movies/" + movie_id + "/theaters/" + theater_id
    spinner = new Spinner(SpinnerBlack).spin()
    Modal.schedule(spinner.el)
    $.getJSON url, (response)->
      Modal.schedule(response[0].description)
  get: (id, ele) =>
    spinner = new Spinner(SpinnerWhite).spin()
    ele.append(spinner.el)
    url = "/movies/" + id
    $.getJSON url, (response)->
      spinner.stop()
      movie             = response.movie
      theaters          = response.theaters
      favorite_theaters = response.favorite_theaters
      in_watchlist      = response.in_watchlist
      Modal.title(movie.name)
      Modal.poster(movie.poster_path)
      Modal.overview(movie.overview)
      Modal.theaters(theaters, favorite_theaters, movie.id)
      if movie.trailer
        Modal.trailer(movie.trailer)
      if in_watchlist
        $("#button_add_watchlist").hide()
        $("#button_delete_watchlist").show()
      else
        $("#button_add_watchlist").show()
        $("#button_delete_watchlist").hide()
      Modal.show()
      Movies.getSchedule(movie.id, theaters[0]["id"])

$(document).ready ->
  $('.movie-poster').on 'click', (e) ->
    e.preventDefault()
    movie_id = $(this).data("movie")
    movie    = Movies.get movie_id, $(this)
  $('select.select-movie-theater').on 'change', -> 
    theater = $(this)
    Movies.getSchedule(theater.data("movie"), theater.val())
  $('#play-trailer').on 'click', (e)->
    e.preventDefault()
    Modal.show_trailer()
  $('.movie-details').on 'hidden.bs.modal', ->
    Modal.show_details()
    Modal.clean()
  $('#link_boton_back_video').on 'click', (e)->
    e.preventDefault()
    Modal.show_details()