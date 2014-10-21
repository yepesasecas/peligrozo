$(document).ready ->
  
  $(".modal-container").on "click", "#play-trailer", (e) ->
    e.preventDefault()
    $(".modal-row-details").hide()
    $(".modal-row-trailer").show()
    $(".boton-back-video").show()
  
  $(".modal-container").on "click", ".boton-back-video", (e) ->
    e.preventDefault()
    $(".modal-row-details").show()
    $(".modal-row-trailer").hide()
    $(".boton-back-video").hide()

  $(".modal-container").on "hide.bs.modal", (e) ->
    $(".modal-trailer").html("")

  $(".modal-container").on "click", "#modal-see-theaters", (e) ->
    e.preventDefault()
    $("#modal-favorite-movie").toggle()
    $("#modal-no-favorite-movie").toggle()

  $(".modal-container").on "click", ".read-more-link", (e) ->
    totalHeight = 0
    $el         = $(this)
    $p          = $el.parent()
    $up         = $p.parent()
    $ps         = $up.find("p:not('.read-more')")
    
    # measure how tall inside should be by adding together heights of all inside paragraphs (except read-more paragraph)
    $ps.each ->
      totalHeight += $(this).outerHeight()
      return
    # Set height to prevent instant jumpdown when max height is removed
    $up.css(
      height: $up.height()
      "max-height": 9999
    ).animate height: totalHeight    
    # fade out read-more
    $p.fadeOut()
    # prevent jump-down
    false
