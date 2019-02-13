$(document).ready(function() {
  var imglength = $('tr:last-child td:last-child span').length;
  var htmlcontent = "";

  if (imglength > 0) {
    for (var i = 0; i <= imglength - 1; i +=1) {
      htmlcontent += $('tr.row-images:last-child td:last-child span').eq(i).html();
    }
  }

  $('tr.row-images:last-child td:last-child').text("");
  $('tr.row-images:last-child td:last-child').html(htmlcontent);
});


$(document).ready(function() {
  $('.display-one-month').on('click', function() {
    if ($('.display-one-month').hasClass('clicked')) {
      $('.inner-CA').css({'display': 'none'});
      $('.display-one-month').removeClass('clicked');
    } else {
      $('.inner-CA').css({'display': 'block'});
      $('.display-one-month').addClass('clicked');
    }
  });
});

$(document).ready(function() {
  document.querySelectorAll('#index_table_produits tbody tr').forEach(
    x => {
      x.setAttribute('draggable', 'true');
    }
  );

  var productRows = Array.from(document.querySelectorAll('#index_table_produits tbody tr'));

  [].forEach.call(productRows, function(product_row) {
    product_row.addEventListener('dragstart', onDragStart, false);
    product_row.addEventListener('dragover', onDragOver, false);
    product_row.addEventListener('drop', onDrop, false);
  });
});

  var draggedProduct = null;
  var draggedIndex = null;
  var rowsInitialPositions = null
  var productRows = null

  onDragOver = (event) => {
    if (event.preventDefault) {
      event.preventDefault();
    }
  }

  onDrop = (event) => {
    if (event.stopPropagation) {
      event.stopPropagation();
    }

    if (draggedProduct != event.srcElement.parentElement) {

      let arrivalElement = event.srcElement.parentElement;
      let arrivalIndex = rowsInitialPositions.indexOf(arrivalElement.querySelector('td.col-id').innerHTML);

      productRows.splice(draggedIndex, 1);
      productRows.splice(arrivalIndex, 0, draggedProduct);
      let finalHTMLs = productRows.map(x => x.innerHTML);
      Array.from(document.querySelectorAll('#index_table_produits tbody tr')).forEach((x, index) => {
       x.innerHTML = finalHTMLs[index]
      });

    }
    return false;
  }

  onDragStart = (event) => {
    rowsInitialPositions = Array.from(document.querySelectorAll('#index_table_produits tbody tr td.col-id')).map(x => x.innerHTML);
    productRows = Array.from(document.querySelectorAll('#index_table_produits tbody tr'));
    draggedProduct = event.srcElement;
    draggedIndex = rowsInitialPositions.indexOf(draggedProduct.querySelector('td.col-id').innerHTML);
    event.dataTransfer.setData('text', draggedProduct);
  }
