class NytScraperJob < ApplicationJob
  include ScrapeHelper
  self.queue_adapter = :sucker_punch

  def perform(recipe_url)
    recipe = NytRecipeScraperService.new(recipe_url.url)
    @recipe = Recipe.create(recipe.get_recipe)
    recipe_url.update(scraped: true)
    ActionCable.server.broadcast 'room_channel', @recipe.attributes
  end
end
