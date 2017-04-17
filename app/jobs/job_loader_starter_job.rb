class JobLoaderStarterJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :low_priority

  loads = ENV['LOADER_COUNT'] || 10
  @loads = loads.to_i

  def perform
    @loads.times do |i|
      i++
      i += RecipeUrl.last.recipe_id if RecipeUrl.count > 0
      UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + i.to_s, 'nyt', i)
    end
  end
end
