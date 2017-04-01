class JobLoaderScraperJob < ApplicationJob
  self.queue_adapter = :sucker_punch

  def perform
    RecipeUrl.next_to_scrape(20).each do |recipe_url|
      NytScraperJob.perform_later(recipe_url)
    end
  end
end
