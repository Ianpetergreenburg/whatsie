$(document).ready(function(){
  $('#ingredients-list').on('mouseenter', 'li.edit-list-item', function(e){
    e.preventDefault();
    var targets = getHoverTarget(e)
    show(targets)
  })
  $('#ingredients-list').on('mouseleave', 'li.edit-list-item', function(e){
    e.preventDefault();
    var targets = getHoverTarget(e)
    hide(targets)
  })
  $('#instructions-list').on('mouseenter', 'li.edit-list-item', function(e){
    e.preventDefault();
    var targets = getHoverTarget(e)
    show(targets)
  })
  $('#instructions-list').on('mouseleave', 'li.edit-list-item', function(e){
    e.preventDefault();
    var targets = getHoverTarget(e)
    hide(targets)
  })
})

function show(targets){
  $(targets).animate({ opacity: 1 }, 100);
}

function hide(targets){
  $(targets).animate({ opacity: 0 }, 100);
}

function getHoverTarget(e){
  return $(e.target).closest('li').find('.hoverable')
}
