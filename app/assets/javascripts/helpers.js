//trim whitespace around string
if(typeof(String.prototype.trim) === "undefined")
{
    String.prototype.trim = function()
    {
        return String(this).replace(/^\s+|\s+$/g, '');
    };
}

//textareas resize to content
$(document).ready(function(){
  $('.content').on('keyup', 'textarea', textAreaAdjust)
})
function textAreaAdjust(o) {
  o = $(o.target)[0]
  $(o).css('height', "1px");
  var height = 25 + o.scrollHeight
  $(o).css('height', height + "px");
}
