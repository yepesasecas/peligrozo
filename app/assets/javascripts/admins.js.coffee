$(document).ready ->
  $("#btn-fetch-movies").on 'click', (e)->
    e.preventDefault()
    $.ajax({
      url:"fetch_movies" 
      success: console.log "loading"
      data: {schedules: $("#checkbox-schedule").is(":checked")}
    })