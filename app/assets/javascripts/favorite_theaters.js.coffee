$(document).ready ->
  path = window.location.pathname
  $("body").css("background-color", "#eee") if path.search('favorite_theaters') != -1 and path.search('users') != -1
  checkboxes = $(".checkbox.checkbox-theaters").slice(15)
  checkboxes.hide()
  
  $("#more-theaters").on "click", (e)->
    e.preventDefault()
    checkboxes = $(".checkbox.checkbox-theaters").slice(15)
    checkboxes.toggle()
  
  $("input[type='checkbox']").on "change", ->
    guardar = $(this).is(":checked")
    if guardar
      url  = path
      data =
        "theater":
          theater_id:this.value
      $.ajax
        type: "POST"
        url: url
        data: data
        success: (response)-> console.log response
    else
      url  = path + "/delete"
      data =
        "theater":
          theater_id:this.value
      $.ajax
        type: "POST"
        url: url
        data: data
        success: (response)-> console.log response
