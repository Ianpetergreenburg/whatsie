class JobLoaderStarterJob < ApplicationJob
  self.queue_adapter = :sidekiq
  queue_as :low_priority
  @@nyt = 1

  def perform
    loads = ENV['LOADER_COUNT'] || 10
    @loads = loads.to_i

    @loads.times do |i|
      UrlLoaderJob.perform_later('https://cooking.nytimes.com/recipes/' + @@nyt.to_s, 'nyt', @@nyt)
      @@nyt += 1
    end
  end
end
