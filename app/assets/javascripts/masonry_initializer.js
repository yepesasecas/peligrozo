function init_masonry(){
  $('.masonry').masonry({
    itemSelector: '.movie'
  });
}

function reload_masonry(){
  console.log($('.masonry'));
  $('.masonry').masonry('reloadItems');
  init_masonry();
}

$(window).load(function(){
  init_masonry();
});

$(document).ready(function(){
  init_masonry();
});
