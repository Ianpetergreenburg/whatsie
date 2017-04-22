$(document).ready(function(){
  var title = $('span.recipe-title').text()
  $('.recipe-header').on('click', '.edit-header', function(e){
    e.preventDefault();
    title = $('span.recipe-title').text()
    $('span.recipe-title').replaceWith(editTitle(title))
    $('span.edit-header').replaceWith(editableHeader)
  })

  $('.recipe-header').on('click', '.cancel-title', function(e){
    e.preventDefault();
    $('#title-edit-form').replaceWith(newTitle(title))
    $('span#editable-header').replaceWith(titleEditPencil)
  })

  $('.recipe-header').on('click', '.update-title', function(e){
    e.preventDefault();
    title = $('#recipe-title-edit').val()
    var id = $('.recipe-page').attr('id')
    $.ajax({
      url: '/recipes/' + id,
      type: 'PUT',
      data: {
              recipe: {
                name: title
              }
            },
      dataType: 'JSON'
    }).done(function(response){
      $('#title-edit-form').replaceWith(newTitle(title))
      $('span#editable-header').replaceWith(titleEditPencil)
    }).catch(function(response){
      console.log(response)
    })
  })


})

var editTitle = function(title){
  return "<span id='title-edit-form' class='form-group'> <input type='text' id='recipe-title-edit' class='form-control' value='" +
  title +
   "'>" +
  "</textarea></span>"
}

var newTitle = function(title){
  return "<span class='recipe-title'>" + title + "</span>"
}

var titleCheckMark = "<span class='glyphicon glyphicon-ok green update-title'></span>"
var titleEditPencil = "<span class='glyphicon glyphicon-pencil blue edit-header'></span>"
var titleXMark = "<span class='cancel-title red'>✖</span>"

var editableHeader = '<span id=editable-header>' +
  titleXMark + titleCheckMark +
  '</span>'
