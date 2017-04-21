$(document).ready(function(){
  checkRandom(0)
})

function checkRandom(counter){
  var clearfix = '<div class="clearfix visible-md-block visible-lg-block"></div>'
  if ($('.random').children().length > 0){
    if(counter%4 == 0 && counter != 0){$('.recipe-cards-container').prepend(clearfix)}
      counter++
    var recipeToAdd = $('.random').children().last().remove()
    $('.recipe-cards-container').prepend(recipeToAdd)

    setTimeout(function(){
      if (!signed_in){
        $('.recipe-cards-container div .save-recipe-btn').remove()
      }
      $('.recipe-cards-container div').first().addClass('col-md-3')
      $('.recipe-cards-container div div').first().addClass('show')
    }, 500)
  }
  setTimeout(function() { checkRandom(counter); } ,3000)
}
