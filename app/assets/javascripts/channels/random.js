App.random = App.cable.subscriptions.create("RandomChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(recipe) {
    $('.random').prepend(recipe.card);
  }
});
