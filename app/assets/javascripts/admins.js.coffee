THEMOVIEDB_URL = "http://api.themoviedb.org/3/search/movie"
API_KEY        = "999e1362be6ce13ac10a05a8122ca9ae"
LANGUAGE       = "ES"

movieDB_url = (query)-> 
  THEMOVIEDB_URL + "?" + "api_key=" + API_KEY + "&language=" + LANGUAGE + "&query=" + query

update_autocomplete = (array) ->
  availableTags = []
  for item in array
    item.icon = "http://image.tmdb.org/t/p/w154" + item.poster_path
    item.label = item.original_title
    availableTags.push item
  $("#tmdb_movie_id").autocomplete(
    source: availableTags,
    AutoFocus: true
  ).autocomplete("instance")._renderItem = (ul, item) ->
    console.log item
    $("<li>").append("<a>" + "<img src='" + item.icon + "' />" + item.label + "</a>").appendTo ul

$(document).ready ->

  $("#tmdb_movie_id").on "input", ->
    $.getJSON movieDB_url(this.value), (response)-> 
      update_autocomplete(response.results)

  $("#tmdb_movie_id").on "autocompleteselect", (event, ui)->
    tr = $(this).parents("tr")
    tr.find(".label_movie_db").html(ui.item.id)
    tr.find("#movie_tmdb_id").val(ui.item.id)