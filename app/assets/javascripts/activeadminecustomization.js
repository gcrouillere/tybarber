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
    product_row.addEventListener('drop', onDragEnd, false);
  });
});

  var draggedProduct = null;
  var draggedIndex = null;
  var initialIDSorder = null
  var productRows = null
  var rowsFinalPositions = null

  onDragOver = (event) => {
    if (event.preventDefault) {
      event.preventDefault();
    }
  }

  onDrop = (event) => {
    if (checkPositionUpdateReference().bool) {
      window.alert(`Vous ne pouvez pas ordonner les produits par rapport au ${checkPositionUpdateReference().paramName}. Veuillez cliquer sur l'en tête de colonne "Position" 2 fois, de manière à afficher les produits dans l'ordre croissant.`)
      return;
    }

    if (draggedProduct != event.srcElement.parentElement) {

      // Get data on target position and element
      let initialPositions = Array.from(document.querySelectorAll('#index_table_produits tbody tr td.col-position')).map(x => x.innerHTML);
      let targetElement = event.srcElement.parentElement;
      let targetIndex = initialIDSorder.indexOf(targetElement.querySelector('td.col-id').innerHTML);

      // Insert product in target position
      productRows.splice(draggedIndex, 1);
      productRows.splice(targetIndex, 0, draggedProduct);

      // Get ordered rows html content
      let finalHTMLs = productRows.map(x => x.innerHTML);

      // Modify DOM with html content
      Array.from(document.querySelectorAll('#index_table_produits tbody tr')).forEach((x, index) => {
       x.innerHTML = finalHTMLs[index]
      });
      document.querySelectorAll('#index_table_produits tbody tr td.col-position').forEach((x, index) => {
       x.innerHTML = index + parseInt(initialPositions[0])
      });
      updatePositionsInDB(initialPositions[0]);
    }
    return false;
  }

  onDragStart = (event) => {
    initialIDSorder = Array.from(document.querySelectorAll('#index_table_produits tbody tr td.col-id')).map(x => x.innerHTML);
    productRows = Array.from(document.querySelectorAll('#index_table_produits tbody tr'));
    draggedProduct = event.srcElement;
    draggedIndex = initialIDSorder.indexOf(draggedProduct.querySelector('td.col-id').innerHTML);
    document.querySelectorAll('#index_table_produits tbody tr').forEach(x => x.classList.remove("drag-end-animation"));
    event.dataTransfer.setData('text', draggedProduct);
  }


  updatePositionsInDB = (startingPosition) => {
    rowsFinalPositions = Array.from(document.querySelectorAll('#index_table_produits tbody tr td.col-id')).map(x => x.innerHTML);
    var urlRoot = window.location.origin;
    $.ajax({
      type: "GET",
      url: `${urlRoot}/ceramiques/update_positions_after_swap_in_admin?finalPositions=[${rowsFinalPositions}]&startingPosition=${startingPosition}`,
      dataType: "JSON"
    }).done((data) => {
      console.log("done")
    }).fail((data) => {
      console.log("fail")
    })
  }

  onDragEnd = (event) => {
    event.currentTarget.classList.add("drag-end-animation");
  }

  function checkPositionUpdateReference() {
    if (window.location.search.length > 10) {
      let lastSearchParamNameAndValue = (window.location.search.split("&").filter(x => !(x.match(/locale|page/)))[0] || "=").split("=")[1]
      let lastSearchParamName = lastSearchParamNameAndValue.substr(0, lastSearchParamNameAndValue.indexOf("_"))
      return {bool: !(lastSearchParamNameAndValue === "position_asc"), paramName: lastSearchParamName}
    } else {
      return {bool: false, paramName: ""}
    }
  }
