$(document).ready(function() {
  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');
  $('.save-recipe-btn').click(function(event){
    event.preventDefault();
    var $this = $(this)
    var ids = $this.prop('id').split(' ')
    var userId = ids[1]
    var recipeId = ids[0]
    $.ajax({
      url: $this.prop('href') + "?&authenticity_token=" + AUTH_TOKEN,
      type: 'POST',
      data: {recipe_book: {user_id: userId, recipe_id: recipeId}},
      dataType: "JSON"

      }).then(function(data){
        $this.addClass('btn-active')
        $this.removeClass('btn-success')
        $this.html('Save To Recipe Book')
        //alert(data.message)
      }).catch(function(data){
        console.log('error:', data)
      })

    })

});
