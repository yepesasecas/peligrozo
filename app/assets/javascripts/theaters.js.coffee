$(document).ready ->
  
  $(".modal-container").on "change", ".select-movie-theater", -> 
    url      = "/movies/" + $(this).data("movie-id") + "/theaters/" + $(this).val()
    spinner  = new Spinner(SpinnerBlack).spin()
    schedule = $(".movie-details").find(".modal-body").find(".modal-schedules").find(".schedules")

    schedule.html(spinner.el)

    $.getJSON url, (response)->
      schedule.html("")
      console.log(response)
      for e in response
        console.log(e)
        classes = "" 
        classes += "coming" if e.coming
        classes += " first_coming" if e.first_coming
        html = "<div class='schedule " + classes + "' >"
        html += "<p>"
        html += e.hours
        html += "</p>"
        html += "</div>"
        schedule.append(html)
