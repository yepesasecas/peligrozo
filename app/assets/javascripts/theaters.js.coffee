$(document).ready ->
  
  $(".modal-container").on "change", ".select-movie-theater", -> 
    url       = "/movies/" + $(this).data("movie-id") + "/theaters/" + $(this).val()
    spinner   = new Spinner(SpinnerBlack).spin()
    schedule = $(".movie-details").find(".modal-body").find(".modal-schedules")

    schedule.html(spinner.el)

    $.getJSON url, (response)->
      schedule.html(response[0].description)
