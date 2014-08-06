aniRightDiv = (track)->
  left  = parseInt track.css("left")
  if last_in_view_port(track) == -1
    track.animate
      left: left - 20
    , 5
  return

aniLeftDiv = (track)->
  left  = parseInt track.css("left")
  if left < 10
    track.animate
      left: left + 10
    , 5
  return

last_in_view_port = (track)->
  last1    = track.find(".movie-poster:last")[0]
  viewport = $(":in-viewport")
  $.inArray(last1, viewport)

$(document).ready ->
  $(".slide-right").bind("mouseenter", ->
    track = $(this).parents(".slider").find(".track")
    @iid  = setInterval(->
      aniRightDiv(track)
      return
    , 25)
    return
  ).bind "mouseleave", ->
    @iid and clearInterval(@iid)
    return

  $(".slide-left").bind("mouseenter", ->
    track = $(this).parents(".slider").find(".track")
    @iid = setInterval(->
      aniLeftDiv(track)
      return
    , 25)
    return
  ).bind "mouseleave", ->
    @iid and clearInterval(@iid)
    return