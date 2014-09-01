$(document).ready ->
  $('.movie-poster').on 'click', (e) ->
    e.preventDefault()
    $.get "/movies/" + $(this).data("movie-id")