class JobLoaderScraperJob < ApplicationJob
  self.queue_adapter = :sucker_punch
  queue_as :high_priority

  def perform
    RecipeUrl.next_to_scrape(5).each do |recipe_url|
      NytScraperJob.perform_later(recipe_url)
    end
  end
end
