class JobLoaderScraperJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :high_priority

  scrapes = ENV['SCRAPER_COUNT'] || 10
  @scrapes = scrapes.to_i



  def perform
    RecipeUrl.next_to_scrape(@scrapes).each do |recipe_url|
      NytScraperJob.perform_later(recipe_url)
    end
  end
end
