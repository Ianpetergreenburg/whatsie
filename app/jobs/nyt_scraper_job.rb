class NytScraperJob < ApplicationJob
  include ScrapeHelper
  self.queue_adapter = :sidekiq
  queue_as :high_priority

  def perform(recipe_url)
    NytRecipeScraperService.new(recipe_url.url)
    recipe_url.update(scraped: true)
    # if @recipe.valid?
      ActionCable.server.broadcast 'random_channel', card: render_recipe(@recipe)
    # end
  end

  private

  def render_recipe(recipe)
    ApplicationController.renderer.render(partial: 'partials/random_recipe_card', locals: { recipe: recipe })
  end
end
