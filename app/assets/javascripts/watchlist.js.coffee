User =
  add_watchlist: (movie_id)->
    user_id = $("body").data("user")
    url = "/users/" + user_id + "/favorite_movies"
    data =
      "movie":
        movie_id: movie_id
    $.ajax
      type: "POST"
      url: url
      data: data
      success: (response)-> 
        $(".message_watchlist").show()
        $(".modal-content").css("margin-top", "-290px")
        setTimeout (->
          $(".message_watchlist").hide()
          $(".modal-content").css("margin-top", "0px")
          $('.movie-details').modal('hide')
          return
        ), 1000

  delete_watchlist: (movie_id)->
    user_id = $("body").data("user")
    url = "/users/" + user_id + "/favorite_movies/delete"
    data =
      "movie":
        movie_id: movie_id
    $.ajax
      type: "POST"
      url: url
      data: data
      success: (response)-> 
        $('.movie-details').modal('hide')
        location.reload true

$(document).ready ->

  $(".modal-container").on "click", "#button_add_watchlist", (e)->
    e.preventDefault()
    movie_id = $(".movie-details").find(".modal-body").find(".select-movie-theater").data("movie-id")
    User.add_watchlist(movie_id)

  $(".modal-container").on "click", "#button_delete_watchlist", (e)->
    e.preventDefault()
    movie_id = $(".movie-details").find(".modal-body").find(".select-movie-theater").data("movie-id")
    User.delete_watchlist(movie_id)
