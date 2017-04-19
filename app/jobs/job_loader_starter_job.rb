class JobLoaderStarterJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :low_priority

  def perform
    loads = ENV['LOADER_COUNT'] || 10
    @loads = loads.to_i

    @loads.times do |i|
      i += RecipeUrl.last.recipe_id if RecipeUrl.count > 0
      UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + i.to_s, 'nyt', i)
    end
  end
end
