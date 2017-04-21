$(document).ready(function(){
  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

  $('#addIngredientBox').on('click', '#add-ingredient', function(e){
    e.preventDefault();
    $('#add-ingredient').remove()
    $('#addIngredientBox').html(newIngredientField)
  })

  $('#addIngredientBox').on('click', '#create-ingredient', function(e){
    e.preventDefault();
    var ingredient = $('#ingredient-to-add').val().trim()
    if (ingredient == ''){
      $('#ingredient-to-add').addClass('failed-enter')
      return
    }
    $('#ingredients-list').append(newIngredient(ingredient))
    replaceWithAddIngredient();
  })

  $('#addIngredientBox').on('focus', '#ingredient-to-add', function(e){
    e.preventDefault()
    $(e.target).removeClass('failed-enter')
  })

  $('#addIngredientBox').on('click', '#cancel-ingredient', function(e){
    e.preventDefault();
    replaceWithAddIngredient();
  })

  $('#ingredients-list').on('click', '.delete-ingredient', function(e){
    e.preventDefault();
    e.target.closest('li').remove()
  })

  $('#ingredients-list').on('click', '.edit-ingredient', function(e){
    e.preventDefault();
    var contentCell = $(e.target).closest('li').find('.ingredient-content')
    var content = $(contentCell).html()
    $(contentCell).html(editIngredient(content))
    $(e.target).closest('td').html(ingCheckMark)
  })

  $('#ingredients-list').on('click', '.update-ingredient', function(e){
    e.preventDefault();
    var contentCell = $(e.target).closest('li').find('.ingredient-content')
    var content = $(contentCell).find('textarea').val()
    $(contentCell).html(content)
    $(e.target).closest('td').html(ingEditPencil + ingXMark)
  })

  $('#save-ingredients').click(function(e){
    e.preventDefault();
    var ingredients = $('#ingredients-list .ingredient-content')
    var ingredientsArray = ingredients.map(function(index){
      return $(this).text()
    })
    var id = $('.recipe-page').attr('id')
    $.ajax({
      url: '/recipes/' + id,
      type: 'PUT',
      data: {
              recipe: {
                ingredients: JSON.stringify(ingredientsArray)
              }
            },
      dataType: 'JSON'
    }).done(function(response){
      $('#ing-flash-container').prepend('<div id="ing-success" class="alert alert-success">' +
       "Ingredients successfully saved" + '</div>')
      setTimeout(function(){$('#ing-success').remove()}, 3000)
    }).catch(function(response){
      console.log(response)
      $('#ing-flash-container').prepend('<div id="ing-danger" class="alert alert-danger">' +
       "Ingredients were not successfully saved" + '</div>')
    })
  })

})

var replaceWithAddIngredient = function(){
  $('#addIngredientBox').html(addIngredientButton)
}

var newIngredient = function(ingredient) {
  return "<li class='edit-list-item'>" +
    "<table class='list-table'>" +
      "<tr>" +
        "<td class='ingredient-move'>" +
          "<span class='ingredient-move' aria-hidden='true'>☰</span>" +
        "</td>" +
        "<td class='ingredient-content'>" +
          ingredient +
        "</td>" +
        "<td class='edit-ingredient-cell align-top'>" +
          ingEditPencil +
          ingXMark +
        "</td>" +
      "</tr>" +
    "</table>" +
  "</li>"
}

var editIngredient = function(ingredient){
  return "<div class='form-group'> <textarea id='ingredient-content-edit' class='form-control ins-ins-edit'>" +
    ingredient +
  "</textarea></div>"
}

var newIngredientField = "<textarea id='ingredient-to-add' class='form-control ins-ins-edit'></textarea>" +
        "<button class='btn btn-info btn-sm' id='create-ingredient'>Create Ingredient</button>" +
        "<button class='btn btn-danger btn-sm' id='cancel-ingredient'>Cancel</button>"
var addIngredientButton = "<button class='btn btn-success' id='add-ingredient'>Add Ingredient</button>"
var ingCheckMark = "<span class='glyphicon glyphicon-ok green update-ingredient'></span>"
var ingEditPencil = "<span class='glyphicon glyphicon-pencil blue edit-ingredient hoverable'></span>"
var ingXMark = "<span class='delete-ingredient hoverable'>✖</span>"
