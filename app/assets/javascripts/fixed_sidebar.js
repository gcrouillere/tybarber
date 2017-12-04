$(document).ready(function() {

  function changeButton() {
    if($('#ceramique-filters-content').size() > 0) {
      if($(document).scrollTop() > $('.ceramique-list').offset().top) {
        $('#ceramique-filters-content').css({
          position: 'fixed',
          top: 20,
        });
      } else {
        $('#ceramique-filters-content').css({
          position: '',
          top: '',
        });
      }
    }
  }

  $(document).scroll(function() {
    changeButton();
  });
})
