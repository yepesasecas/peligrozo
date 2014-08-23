last_background = (index)->
  if index is 4
    index = 1
  else
    index = index + 1

$(document).ready ->
  path = window.location.pathname
  if path.search('landing/index') != -1
    (->
      background_stage = 1
      Background = ->
        $(".landing-back").css "background", "url(/assets/background_"+background_stage+".png) no-repeat"
        $(".landing-back").css "background-size", "cover"
        $(".landing-back").css "bottom", "0px"
        $(".landing-back").css "position", "absolute"
        $(".landing-back").css "top", "0px"
        $(".landing-back").css "min-width", "100%"
        background_stage = last_background(background_stage)
        setTimeout (->
          Background()
          return
        ), 3000
        return
      background_stage = 1
      Background()
      return
    )()
