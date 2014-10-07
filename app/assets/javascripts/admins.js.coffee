THEMOVIEDB_URL = "http://api.themoviedb.org/3/search/movie"
API_KEY        = "999e1362be6ce13ac10a05a8122ca9ae"
LANGUAGE       = "ES"

movieDB_url = (query)-> 
  THEMOVIEDB_URL + "?" + "api_key=" + API_KEY + "&language=" + LANGUAGE + "&query=" + query

movieDB_trailer_url = (movie_id, language)->
  "http://api.themoviedb.org/3/movie/" + movie_id + "/videos" + "?" + "api_key=" + API_KEY + "&language=" + language

update_autocomplete = (array) ->
  items = []
  for item in array
    item.icon  = "http://image.tmdb.org/t/p/w154" + item.poster_path
    item.label = item.original_title
    items.push item
  items

$(document).ready ->

  $(".tmdb_movie_id").on "input", ->
    console.log "id"
    tr = $(this).parents("tr")
    tr.find("#movie_trailer").val("")
    tr.find(".movie_trailer").html("")
    $.getJSON movieDB_url(this.value), (response)-> 
      items = update_autocomplete(response.results)
      tr.find(".tmdb_movie_id").autocomplete(
        source: items,
        AutoFocus: true
      ).autocomplete("instance")._renderItem = (ul, item) ->
        $("<li>").append("<a>" + "<img src='" + item.icon + "' />" + item.label + "</a>").appendTo ul

  $(".tmdb_movie_id").on "autocompleteselect", (event, ui)->
    movie_id = ui.item.id
    tr = $(this).parents("tr")
    tr.find(".label_movie_db").html(movie_id)
    tr.find("#movie_tmdb_id").val(movie_id)
    $.getJSON movieDB_trailer_url(movie_id, "ES"), (response)->
      videos = response.results
      if videos.length > 0
        for video in videos
          console.log "entraaaa"
          if video.site == "YouTube"
            tr.find("#movie_trailer").val(video.key)
            tr.find(".movie_trailer").html("<iframe frameborder='0' height='200' src='http://www.youtube.com/embed/" + video.key + "' width='300'></iframe>")
      else
        $.getJSON movieDB_trailer_url(movie_id, "EN"), (response)->
          videos = response.results
          for video in videos
            if video.site == "YouTube"
              tr.find("#movie_trailer").val(video.key)
              tr.find(".movie_trailer").html("<iframe frameborder='0' height='200' src='http://www.youtube.com/embed/" + video.key + "' width='300'></iframe>")
