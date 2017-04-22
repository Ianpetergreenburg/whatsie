$(document).ready(function(){
  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

  $('#addInstructionBox').on('click', '#add-instruction', function(e){
    e.preventDefault();
    $('#add-instruction').remove()
    $('#addInstructionBox').html(newInstructionField)
  })

  $('#addInstructionBox').on('click', '#create-instruction', function(e){
    e.preventDefault();
    var instruction = $('#step-to-add').val().trim()
    if (instruction == ''){
      $('#step-to-add').addClass('failed-enter')
      return
    }
    $('#instructions-list').append(newInstruction(instruction))
    replaceWithAdd();
  })

  $('#addInstructionBox').on('focus', '#step-to-add', function(e){
    e.preventDefault()
    $(e.target).removeClass('failed-enter')
  })

  $('#addInstructionBox').on('click', '#cancel-instruction', function(e){
    e.preventDefault();
    replaceWithAdd();
  })

  $('#instructions-list').on('click', '.delete-instruction', function(e){
    e.preventDefault();
    e.target.closest('li').remove()
  })

  $('#instructions-list').on('click', '.edit-instruction', function(e){
    e.preventDefault();
    var contentCell = $(e.target).closest('li').find('.instruction-content')
    var content = $(contentCell).html()
    $(contentCell).html(editInstruction(content))
    $(e.target).closest('td').html(checkMark)
  })

  $('#instructions-list').on('click', '.update-instruction', function(e){
    e.preventDefault();
    var contentCell = $(e.target).closest('li').find('.instruction-content')
    var content = $(contentCell).find('textarea').val()
    $(contentCell).html(content)
    $(e.target).closest('td').html(editPencil + xMark)
  })

  $('#save-instructions').click(function(e){
    e.preventDefault();
    instructionToSave();
    var instructions = $('#instructions-list .instruction-content')
    var instructionsArray = instructions.map(function(index){
      return $(this).text()
    })
    var id = $('.recipe-page').attr('id')
    $.ajax({
      url: '/recipes/' + id,
      type: 'PUT',
      data: {
              recipe: {
                instructions: JSON.stringify(instructionsArray)
              }
            },
      dataType: 'JSON'
    }).done(function(response){
      $('#ins-flash-container').prepend('<div id="ins-success" class="alert alert-success">' +
       "Instructions successfully saved" + '</div>')
      setTimeout(function(){$('#ins-success').remove()}, 3000)
    }).catch(function(response){
      console.log(response)
    })
  })

})
var instructionToSave = function(){
  $('.update-instruction').each(function(index){
      var contentCell = $(this).closest('li').find('.instruction-content')
      var content = $(contentCell).find('textarea').val()
      $(contentCell).html(content)
      $(this).closest('td').html(editPencil + xMark)
  })
}
var replaceWithAdd = function(){
  $('#addInstructionBox').html(addStepButton)
}

var newInstruction = function(instruction) {
  return "<li class='edit-list-item'>" +
    "<table class='list-table'>" +
      "<tr>" +
        "<td class='instruction-move'>" +
          "<span class='instruction-move' aria-hidden='true'>☰</span>" +
        "</td>" +
        "<td class='instruction-content'>" +
          instruction +
        "</td>" +
        "<td class='edit-instruction-cell align-top'>" +
          editPencil +
          xMark +
        "</td>" +
      "</tr>" +
    "</table>" +
  "</li>"
}

var editInstruction = function(instruction){
  return "<div class='form-group'> <textarea id='instruction-content-edit' class='form-control ins-ins-edit'>" +
    instruction +
  "</textarea></div>"
}

var newInstructionField = "<textarea id='step-to-add' class='form-control ins-ins-edit'></textarea>" +
        "<button class='btn btn-info btn-sm' id='create-instruction'>Create Step</button>" +
        "<button class='btn btn-danger btn-sm' id='cancel-instruction'>Cancel</button>"
var addStepButton = "<button class='btn btn-success' id='add-instruction'>Add Step</button>"
var checkMark = "<span class='glyphicon glyphicon-ok green update-instruction'></span>"
var editPencil = "<span class='glyphicon glyphicon-pencil blue edit-instruction hoverable'></span>"
var xMark = "<span class='delete-instruction hoverable'>✖</span>"
