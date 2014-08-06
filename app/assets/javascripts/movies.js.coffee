Modal = 
  show: ->  
    $('.movie-details').modal('show')
  title: (title) -> 
    $(".movie-details").find(".modal-title").html(title)
  poster: (poster_path) ->
    $(".movie-details").find(".modal-poster-img").html("<img alt='Logo' id='logo' class='poster-modal hidden-xs' src=" + poster_path + ">")
  overview: (overview) -> 
    $(".movie-details").find(".modal-body").find(".modal-overview").html(overview)
  theaters: (theaters, movie_id) -> 
    select = $(".movie-details").find(".modal-body").find(".select-movie-theater")
    select.html("")
    select.append("<option value=" + theater.id + ">" + theater.name + "</option>") for theater in theaters
    select.data("movie", movie_id)
  schedule: (description)-> 
    $(".movie-details").find(".modal-body").find(".modal-schedules").html(description)
  trailer: (id)->
    $(".btn-trailer-play").show()
    $(".movie-details").find(".modal-body").find(".modal-trailer").html("<iframe width='598' height='419'
src=http://www.youtube.com/embed/" + id + " frameborder='0' allowfullscreen></iframe>")
  clean: ->
    $(".btn-trailer-play").hide()
    $(".movie-details").find(".modal-body").find(".modal-trailer").html("")

Movies =
  getSchedule: (movie_id, theater_id)->
    console.log(movie_id + " - " + theater_id)
    url = "/movies/" + movie_id + "/theaters/" + theater_id
    spinner = new Spinner(SpinnerOpts).spin()
    Modal.schedule(spinner.el)
    $.getJSON url, (response)->
      Modal.schedule(response[0].description)
  get: (id) =>
    url = "/movies/" + id
    $.getJSON url, (response)->
      movie    = response.movie
      theaters = response.theaters
      Modal.title(movie.name)
      Modal.poster(movie.poster_path)
      Modal.overview(movie.overview)
      Modal.theaters(theaters, movie.id)
      Modal.trailer(movie.trailer) if movie.trailer
      Modal.show()
      Movies.getSchedule(movie.id, theaters[0]["id"])

$(document).ready ->
  $('.movie-poster').on 'click', (e) ->
    e.preventDefault()
    movie_id = $(this).data("movie")
    movie = Movies.get movie_id
  $('select.select-movie-theater').on 'change', -> 
    theater = $(this)
    Movies.getSchedule(theater.data("movie"), theater.val())
  $('#play-trailer').on 'click', ->
    $('.modal-row-trailer').show()
    $('.modal-row-details').hide()

  $('.movie-details').on 'hidden.bs.modal', ->
    $('.modal-row-trailer').hide()
    $('.modal-row-details').show()
    Modal.clean()
    console.log 'hide'


    