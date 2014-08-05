last_in_view_port = (track)->
  last1    = track.find(".movie-poster:last")[0]
  viewport = $(":in-viewport")
  $.inArray(last1, viewport)

$(document).ready ->
  SLIDE_WIDTH = 172
  
  $(".slide-left").on 'click', (e)->
    e.preventDefault()
    track = $(this).parents(".slider").find(".track")
    left  = parseInt track.css("left")
    if left < 10
      track.animate {left: left + SLIDE_WIDTH}, 150, ->
  
  $(".slide-right").on 'click', (e)->
    e.preventDefault()
    track = $(this).parents(".slider").find(".track")
    left  = parseInt track.css("left")
    if last_in_view_port(track) == -1
      track.animate {left: left - SLIDE_WIDTH}, 150, ->
