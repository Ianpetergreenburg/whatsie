class NytScraperJob < ApplicationJob
  include ScrapeHelper
  self.queue_adapter = :sucker_punch

  def perform(recipe_url)
    recipe = Recipe.scrape_for_recipe recipe_url.url

    recipe_body = recipe.css('.recipe-instructions')

    name = recipe.at_css('.recipe-title').text.gsub("\n", '').strip
    ingredients = Recipe.scrape_ingredients recipe_body
    ingredients = noko_to_s ingredients
    instructions = Recipe.scrape_instructions recipe_body
    instructions = noko_to_s instructions
    images = recipe.css('.media-container img')
    if images.empty?
      image_url = ''
    else
      image_url = images.attr('src').text
    end

    Recipe.create(url: recipe_url.url, name: name, ingredients: ingredients, instructions: instructions, image_url: image_url)
    recipe_url.update(scraped: true)
  end
end
