$(document).ready(function(){
  checkRandom()
})

function checkRandom(){
  if ($('.random').children().length > 0){

    var recipeToAdd = $('.random').children().last().remove()
    $('.recipe-cards-container').prepend(recipeToAdd)

    setTimeout(function(){
      $('.recipe-cards-container div').first().addClass('col-md-3')
      $('.recipe-cards-container div div').first().addClass('show')
    }, 1000)
  }
  setTimeout(function() { checkRandom(); } ,3000)
}
