class NytScraperJob < ApplicationJob
  self.queue_adapter = :sucker_punch

  def perform(recipe_url)
    recipe = Recipe.scrape_for_recipe recipe_url.url
    recipe_body = recipe.css('.recipe-instructions')
    ingredients = Recipe.scrape_ingredients recipe_body
    instructions = Recipe.scrape_instructions recipe_body
    p recipe_body

  end
end
