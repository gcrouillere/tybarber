$(document).ready(function() {
  $('body').on('click', '.thumbnail', toggleActiveThumbnail);
  $('#zoom01').elevateZoom({
    zoomType: "inner",
    cursor: "crosshair",
  });
});

function toggleActiveThumbnail(event) {
  // Thumbnail and img-front update
  $('.thumbnail').removeClass('active');
  var source = $(this).attr("src");
  $(this).addClass('active');
  $('.img-front').attr("src", source);
  $('.img-front').attr("data-zoom-image", source);

  // InnerZoom update : destroy then creates
  $('.zoomContainer').remove();
  $('#zoom01').removeData('elevateZoom');
  $('#zoom01').removeData('zoomImage');
  $('#zoom01').elevateZoom({
    zoomType: "inner",
    cursor: "crosshair",
  });
}
