$(document).ready ->
  
  path = window.location.pathname
  if path.search('favorite_theaters') != -1 and path.search('users') != -1
    $("body").css("background-color", "#eee")
  checkboxes = $(".checkbox.checkbox-theaters").slice(15)
  checkboxes.hide()
  
  $("#more-theaters").on "click", (e)->
    e.preventDefault()
    checkboxes = $(".checkbox.checkbox-theaters").slice(15)
    checkboxes.toggle()
  
  $("input[type='checkbox']").on "change", ->
    guardar = $(this).is(":checked")
    url = 
      if guardar
        path
      else
        path + "/delete"
    data =
      "theater":
        theater_id:this.value
    $.ajax
      type: "POST"
      url: url
      data: data
      success: (response)-> console.log response 

  $("#countries-list").on 'change', (ele)->
    $(".checkbox-theaters").hide()
    $(".country-#{$("#countries-list").val()}").show()
