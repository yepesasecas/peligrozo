$(document).ready ->
  SLIDE_WIDTH = 17
  MOVIE_WIDTH = 172

  $('#slide-left1').on 'click', (e)->
    e.preventDefault()
    track = $('#track1')
    left1 = parseInt track.css('left')
    if left1 < 10
      track.css('left', left1 + SLIDE_WIDTH)

  $('#slide-right1').on 'click', (e)->
    e.preventDefault()
    track = $('#track1')
    width = MOVIE_WIDTH* track.data 'width'
    left1 = parseInt track.css('left')
    track.css('left', left1 - SLIDE_WIDTH)

  $('#slide-left2').on 'click', (e)->
    e.preventDefault()
    track = $('#track2')
    left1 = parseInt track.css('left')
    if left1 < 10
      track.css('left', left1 + SLIDE_WIDTH)

    console.log "left" + left1

  $('#slide-right2').on 'click', (e)->
    e.preventDefault()
    track = $('#track2')
    width = MOVIE_WIDTH * track.data 'width'
    track.css('left', left1 - SLIDE_WIDTH)
