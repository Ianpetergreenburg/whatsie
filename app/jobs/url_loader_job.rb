class UrlLoaderJob < ApplicationJob
  include UrlHelper
  self.queue_adapter = :sidekiq
  queue_as :low_priority

  def perform(url, source, recipe_id)
    return false if RecipeUrl.find_by(source: source, recipe_id: recipe_id)
    if url_exist? url
      RecipeUrl.create(source: source, recipe_id: recipe_id, scraped: false, plausible: true, url: url)
    else
      RecipeUrl.create(source: source, recipe_id: recipe_id, scraped: false, plausible: false, url: url)
    end
  end
end
