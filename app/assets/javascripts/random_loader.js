$(document).ready(function(){
  checkRandom()
})

function checkRandom(){
  var currentUserId = window.currentUserId

  if ($('.random').children().length > 0){

    var recipeToAdd = $('.random').children().last().remove()
    var id = recipeToAdd.find('.save-recipe-btn').attr('id')

    recipeToAdd.find('.save-recipe-btn').attr('id', id + currentUserId)
    $('.recipe-cards-container').prepend(recipeToAdd)

    setTimeout(function(){
      $('.recipe-cards-container div').first().addClass('col-md-3')
      $('.recipe-cards-container div div').first().addClass('show')
    }, 10)
  }
  setTimeout(function() { checkRandom(); } ,3000)
}
