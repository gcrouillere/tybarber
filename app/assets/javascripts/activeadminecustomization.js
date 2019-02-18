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

function OnloadFunction() {
  // PRODUCT POSITION UPDATE BY DRAG N DROP
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

  // PRODUCT FIELD UPDATE ON BLUR
   var editableCells = Array.from(document.querySelectorAll("td.col.col-name, td.col.col-description, td.col.col-stock, td.col.col-weight,td.col.col-price_cents"));

  [].forEach.call(editableCells, function(editableCell){
    editableCell.addEventListener('click', clickOnEditableCell, false);
  });
}

$(document).ready(OnloadFunction);

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
    console.log("done");
    OnloadFunction();
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

// PRODUCT FIELD UPDATE ON BLUR

clickOnEditableCell = (event) => {
  cell = event.target
  cell.parentElement.setAttribute('draggable', 'false');
  initialValue = cell.innerText
  updatingField = cell.classList[1].split("-")[1];
  productID = cell.parentElement.id.split("_")[1]
  var urlRoot = window.location.origin;

  // Get value with input
  if (Array.from(cell.classList).indexOf("editing") === -1) {
    cell.classList.add("editing");
    value = cell.innerText;
    cell.innerHTML = `<input type=${updatingField.match(/name|description/) ? "text" : "number"} name="${updatingField}" value="${value}" class="editingInput"/>`;

    // Submit on blur
    input = document.querySelector(".editingInput")
    input.focus();
    input.addEventListener('blur', function( event ) {
    inputType = input.getAttribute('type')

    relatedCell = this.parentElement;
    relatedRow = this.parentElement.parentElement;
    relatedCell.classList.remove('editing');
    newValue = this.value;

      //VALIDATION
      if (validateField(newValue, updatingField, inputType)) {

        //DOM UPDATE
        relatedCell.innerHTML = newValue;
        relatedRow.setAttribute('draggable', 'true')

        // UPDATE DB
        $.ajax({
          type: "PATCH",
          url: `${urlRoot}/produits/${productID}`,
          dataType: "JSON",
          data: {ceramique: {[updatingField]: newValue}}
        }).done((data) => {
          console.log("done");
          OnloadFunction();
        }).fail((data) => {
          console.log("fail")
          debugger
        })
      } else {
        console.log('NOK')
        relatedCell.innerHTML = initialValue;
      }
    })
  }
}

validateField = (fieldValue, updatingField, inputType) => {
  return updatingField !== "" && (inputType == "number" ? (fieldValue > 0 && fieldValue.isInteger) : true)
}
