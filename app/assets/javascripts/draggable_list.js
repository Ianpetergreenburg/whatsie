$(document).ready(function(){
  if (!at_edit){return}
  var elIng = document.getElementById('ingredients-list');
    var sortableIns = Sortable.create(elIng, {
    handle: '.ingredient-move',
    animation: 150
  });

  var elIns = document.getElementById('instructions-list');
  var sortableIns = Sortable.create(elIns, {
    handle: '.instruction-move',
    animation: 150
  });
})
