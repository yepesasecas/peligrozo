$(document).ready ->
  
  path = window.location.pathname
  if path.search('history') != -1 and path.search('users') != -1
    $("body").css("background-color", "#eee")