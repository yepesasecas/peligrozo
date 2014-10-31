$(document).ready ->
  
  $(".modal-container").on "click", "#play-trailer", (e) ->
    e.preventDefault()
    player = createYoutubePlayer( 'player', $("#player").data("id") )
    $(".modal-row-details").hide()
    $(".modal-row-trailer").show()
    $(".boton-back-video").show()
  
  $(".modal-container").on "click", ".boton-back-video", (e) ->
    e.preventDefault()
    $(".modal-row-details").show()
    $(".modal-row-trailer").hide()
    $(".boton-back-video").hide()

  $(".modal-container").on "hide.bs.modal", (e) ->
    $(".modal-trailer").html("")

  $(".modal-container").on "click", "#modal-see-theaters", (e) ->
    e.preventDefault()
    $("#all-theaters").toggle()
    $("#no-theaters").toggle()
