function playsound() {
  var sound = document.getElementsByTagName("audio")[0];
  sound.currentTime = 0;
  sound.play()
}

function stopsound() {
  var sound = document.getElementsByTagName("audio")[0];
  sound.pause()
  sound.currentTime = 0;
}
