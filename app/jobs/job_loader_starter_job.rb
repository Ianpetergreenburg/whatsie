class JobLoaderStarterJob < ApplicationJob
    self.queue_adapter = :sucker_punch
    queue_as :low_priority

    def perform
      10000.times do |i|
        i += RecipeUrl.last.recipe_id
        UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + i.to_s, 'nyt', i)
      end
    end
end
