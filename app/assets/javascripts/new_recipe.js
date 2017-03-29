$(document).ready(function() {

  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

  $('.save-recipe-btn').click(function(event){
    event.preventDefault();
    var $this = $(this)

    var ids = $this.prop('id').split(' ')
    var userId = ids[1]
    var recipeId = ids[0]

    $.post({
      url: '/recipe_books',
      data: {recipe_book: {user_id: userId, recipe_id: recipeId}},
      dataType: "JSON"

      }).then(function(data){
        $this.toggleClass('btn-primary')
        $this.toggleClass('btn-success')
        if ($this.html() == 'Saved!') {
          $this.html('Save To Recipe Book')
        } else {
          $this.html('Saved!')
        }
      }).catch(function(data){
        console.log('error:', data)
      })

    })

});
