$(document).ready ->
  $(".modal-container").on "show.bs.modal", ".movie-details", (e)->
    console.log "probando"
  $(".modal-container").on "change", ".select-movie-theater", -> 
    url       = "/movies/" + $(this).data("movie-id") + "/theaters/" + $(this).val()
    spinner   = new Spinner(SpinnerBlack).spin()
    eschedule = $(".movie-details").find(".modal-body").find(".modal-schedules")

    eschedule.html(spinner.el)

    $.getJSON url, (response)->
      eschedule.html(response[0].description)
