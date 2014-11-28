set_stars = (e, stars)->
  $(".btn-group-stars a").removeClass("selected")
  $(e).addClass("selected")
  $("#favorite_movie_stars").val(stars)

$(document).ready ->
  
  $(".modal-container").on "click", "#play-trailer", (e) ->
    e.preventDefault()
    player = createYoutubePlayer( 'player', $("#player").data("id") )
    $(".modal-row-details").hide()
    $(".modal-row-trailer").show()
    $(".boton-back-video").show()
  
  $(".modal-container").on "click", ".boton-back-video", (e) ->
    e.preventDefault()
    $(".modal-row-trailer").hide()
    $(".boton-back-video").hide()
    $(".section-seen").hide()
    $(".modal-row-details").show()
    $(".section-movie").show()

  $(".modal-container").on "click", "#button-seen", (e) ->
    e.preventDefault()
    $(".section-movie").hide()
    $(".section-seen").show()
    $(".boton-back-video").show()

  $(".modal-container").on "click", "#movie-one-star", (e) ->
    e.preventDefault()
    set_stars(this, 1)

  $(".modal-container").on "click", "#movie-three-star", (e) ->
    e.preventDefault()
    set_stars(this, 3)

  $(".modal-container").on "click", "#movie-five-star", (e) ->
    e.preventDefault()
    set_stars(this, 5)

  $(".modal-container").on "hide.bs.modal", (e) ->
    $(".modal-trailer").html("")

  $(".modal-container").on "click", "#modal-see-theaters", (e) ->
    e.preventDefault()
    $("#all-theaters").toggle()
    $("#no-theaters").toggle()
