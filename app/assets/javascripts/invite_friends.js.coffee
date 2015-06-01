$(document).ready ->
  path = window.location.pathname
  $("body").css("background-color", "#eee") if path.search('invite_friends') != -1 and path.search('users') != -1
  checkboxes = $(".checkbox.checkbox-friends").slice(10)
  checkboxes.hide()

  $("#more-friends").on "click", (e)->
    e.preventDefault()
    checkboxes = $(".checkbox.checkbox-friends").slice(15)
    checkboxes.toggle()

  $("input[type='checkbox']").on "change", ->
    guardar = $(this).is(":checked")
    url =
      if guardar
        path
      else
        path + "/delete"
    data =
      "friend":
        friend_id:this.value
    $.ajax
      type: "POST"
      url: url
      data: data
      success: (response)-> console.log response
