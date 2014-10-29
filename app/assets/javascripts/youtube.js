function onPlayerReady(event) {
  event.target.playVideo();
}

function createYoutubePlayer(id){
  new YT.Player('player', {
    height: '419',
    width: '598',
    videoId: id,
    events: {
      'onReady': onPlayerReady
    }
  });
}
