$(document).ready ->
  path = window.location.pathname
  $("body").css("background-color", "#eee") if path.search('favorite_genres') != -1 and path.search('users') != -1
  trs = $("tr.genres").slice(9)
  trs.hide()

  $("#more-genres").on "click",  ->
    trs = $("tr.genres").slice(9)
    trs.toggle()