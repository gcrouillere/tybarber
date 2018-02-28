$(document).ready(function() {
  if ($('.front-image-div').size() > 0) {
    $('.front-image-div').hover(function(){
      $('.imageoverlay').css("display", "none");
    });
  }
});
