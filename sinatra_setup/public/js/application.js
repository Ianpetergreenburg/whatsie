$(document).ready(function() {
  $('.save-recipe-form').submit(function(event){
    event.preventDefault();
    var $this = $(this)

    $.ajax({
      url: $this.prop('action'),
      type: 'POST',
      data: $this.serialize()

      }).done(function(data){
        alert(data.message)
      }).error(function(data){
        alert(data.message)
      })

    })

});
