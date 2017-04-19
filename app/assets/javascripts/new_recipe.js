$(document).ready(function() {

  $.ajaxSetup({
    headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
  });

  $('body').on('click', '.save-recipe-btn', function(event){
    event.preventDefault();
    var $this = $(this)

    var recipeId = $this.prop('id')

    $.post({
      url: '/recipe_books',
      data: {recipe_book: {recipe_id: recipeId}},
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
