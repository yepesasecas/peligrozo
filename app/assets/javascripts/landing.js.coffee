$(document).ready ->
  path = window.location.pathname
  if path.search('landing/index') != -1
    (->
      Background_Stage = 0
      Background = ->
        switch Background_Stage
          when 0
            $(".landing-back").css "background", "url(/assets/background_1.png) no-repeat"
            $(".landing-back").css "background-size", "cover"
            $(".landing-back").css "bottom", "0px"
            $(".landing-back").css "position", "absolute"
            $(".landing-back").css "top", "0px"
            $(".landing-back").css "min-width", "100%"
            Background_Stage++
            setTimeout (->
              Background()
              return
            ), 3000
          when 1
            $(".landing-back").css "background", "url(/assets/background_2.png) no-repeat"
            $(".landing-back").css "background-size", "cover"
            $(".landing-back").css "bottom", "0px"
            $(".landing-back").css "position", "absolute"
            $(".landing-back").css "top", "0px"
            $(".landing-back").css "min-width", "100%"
            Background_Stage++
            setTimeout (->
              Background()
              return
            ), 3000
          when 2
            $(".landing-back").css "background", "url(/assets/background_3.png) no-repeat"
            $(".landing-back").css "background-size", "cover"
            $(".landing-back").css "bottom", "0px"
            $(".landing-back").css "position", "absolute"
            $(".landing-back").css "top", "0px"
            $(".landing-back").css "min-width", "100%"
            Background_Stage++
            setTimeout (->
              Background()
              return
            ), 3000
          when 3
            $(".landing-back").css "background", "url(/assets/background_4.png) no-repeat"
            $(".landing-back").css "background-size", "cover"
            $(".landing-back").css "bottom", "0px"
            $(".landing-back").css "position", "absolute"
            $(".landing-back").css "top", "0px"
            $(".landing-back").css "min-width", "100%"
            Background_Stage = 0 #Reset
            setTimeout (->
              Background()
              return
            ), 3000
        return
      Background_Stage = 0
      Background()
      return
    )()
