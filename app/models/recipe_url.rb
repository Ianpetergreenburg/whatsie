class RecipeUrl < ActiveRecord::Base
  validates_presence_of :recipe_id, :source
  validates_uniqueness_of :recipe_id, scope: :source
  validates :plausible, :scraped, inclusion: { in: [ true, false ] }

  def self.next_to_scrape(amount = 10)
    RecipeUrl.where(plausible: true, scraped: false).limit(amount)
  end
end
