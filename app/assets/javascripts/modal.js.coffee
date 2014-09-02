$(document).ready ->
  $(".modal-container").on "click", "#play-trailer", (e) ->
    e.preventDefault()
    $(".modal-row-details").hide()
    $(".modal-row-trailer").show()
    $(".boton-back-video").show()
  $(".modal-container").on "click", ".boton-back-video", (e) ->
    e.preventDefault()
    $(".modal-row-details").show()
    $(".modal-row-trailer").hide()
    $(".boton-back-video").hide()