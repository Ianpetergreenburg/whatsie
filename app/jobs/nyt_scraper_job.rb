class NytScraperJob < ApplicationJob
  include ScrapeHelper
  self.queue_adapter = :sucker_punch

  def perform(recipe_url)
    recipe = NytRecipeScraperService.new(recipe_url.url)
    @recipe = Recipe.create(recipe.get_recipe)
    recipe_url.update(scraped: true)
    p @recipe.attributes
    ActionCable.server.broadcast 'random_channel', message: render_recipe(@recipe)
  end

  private

  def render_recipe(recipe)
    ApplicationController.renderer.render(partial: 'partials/recipe_card', locals: { recipe: recipe })
  end
end
