class JobLoaderStarterJob < ApplicationJob
    self.queue_adapter = :sucker_punch

    def perform
      10.times do |i|
        i += RecipeUrl.last.recipe_id
        UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + i.to_s, 'nyt', i)
      end
    end
end
