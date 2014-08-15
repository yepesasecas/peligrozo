$(document).ready ->
  path = window.location.pathname
  $("body").css("background-color", "#eee") if path.search('favorite_theaters') != -1 and path.search('users') != -1
  $("input[type='checkbox']").on "change", ->
    guardar = $(this).is(":checked")
    if guardar
      url  = window.location.pathname
      data =
        "theater":
          theater_id:this.value
      $.ajax
        type: "POST"
        url: url
        data: data
        success: (response)-> console.log response
    else
      url  = window.location.pathname + "/delete"
      data =
        "theater":
          theater_id:this.value
      $.ajax
        type: "POST"
        url: url
        data: data
        success: (response)-> console.log response
