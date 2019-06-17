const modules = {
  toolbar: [
    [{ 'header': [1, 2, 3, false] }],
    ['bold', 'italic', 'underline','strike', 'blockquote'],
    [{'list': 'ordered'}, {'list': 'bullet'}, {'indent': '-1'}, {'indent': '+1'}],
    ['link']
  ]
}

$(document).ready(
  document.querySelectorAll(".text-editor-form").forEach( node => {

    var nodeRef = parseInt(node.getAttribute("block-ref"))
    var editor = new Quill(`#quill-editor-${nodeRef}`, { theme: 'snow', modules: modules });
    var form = document.querySelector(`.text-editor-form[block-ref="${nodeRef}"]`);
    form.addEventListener('submit', function(event) { manageArticle(event, nodeRef, editor) })

  })
)

function manageArticle(event, nodeRef, editor) {
  document.querySelector(`#quill-editor-${nodeRef} .ql-editor`).classList.remove("sucess", "failure")

  event.preventDefault()
  var urlRoot = window.location.origin;
  var id = parseInt(document.getElementById(`quill-article-id-${nodeRef}`).getAttribute("article_id"))
  var name = document.getElementById(`quill-name-${nodeRef}`).getAttribute("name")
  var user_id = parseInt(document.getElementById(`quill-user-id-${nodeRef}`).getAttribute("user_id"))
  var content = editor.root.innerHTML

  if (id === -1) {
    createArticle(urlRoot, user_id, name, content, nodeRef)
  } else {
    updateArticle(urlRoot, id, content, nodeRef)
  }
}

function updateArticle(urlRoot, id, content, nodeRef) {
  $.ajax({
    type: "PUT",
    url: `${urlRoot}/articles/${id}`,
    dataType: "JSON",
    data: {article: { id: id, content: content }}
  }).done((data) => {
    console.log("done");
    document.querySelector(`#quill-editor-${nodeRef} .ql-editor`).classList.add("sucess")
  }).fail((data) => {
    console.log("fail")
    document.querySelector(`#quill-editor-${nodeRef} .ql-editor`).classList.add("failure")
  })
}

function createArticle(urlRoot, user_id, name, content, nodeRef) {
  $.ajax({
    type: "POST",
    url: `${urlRoot}/articles`,
    dataType: "JSON",
    data: {article: { content: content, name: name, user_id: user_id }}
  }).done((data) => {
    console.log(data)
    document.getElementById(`quill-article-id-${nodeRef}`).setAttribute("article_id", data.id)
    document.querySelector(`#quill-editor-${nodeRef} .ql-editor`).classList.add("sucess")
  }).fail((data) => {
    console.log("fail")
    document.querySelector(`#quill-editor-${nodeRef} .ql-editor`).classList.add("failure")
  })
}
