$(document).ready(function() {
  var AUTH_TOKEN = $('meta[name=csrf-token]').attr('content');

  $('.save-recipe-form').submit(function(event){
    event.preventDefault();
    var $this = $(this)
    $.ajax({
      url: $this.prop('action'),
      type: 'POST',
      data: $this.serialize()

      }).then(function(data){
        alert(data.message)
      }).catch(function(data){
        console.log(data)
        // alert('couldn\'t pass the data properly')
      })

    })

});
