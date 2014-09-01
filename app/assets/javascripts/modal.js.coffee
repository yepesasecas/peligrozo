$(document).ready ->
  $(".modal-container").on "click", "#play-trailer", (e) ->
    console.log "click"
    e.preventDefault()
    $(".modal-row-details").hide()
    $(".modal-row-trailer").show()
    $(".boton-back-video").show()
  $(".modal-container").on "click", ".boton-back-video", (e) ->
    $(".modal-row-details").show()
    $(".modal-row-trailer").hide()
    $(".boton-back-video").hide()