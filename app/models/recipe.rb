require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'

class Recipe < ActiveRecord::Base
  has_many :recipe_books
  has_many :users, through: :recipe_books

  validates_presence_of :name
  validates_presence_of :ingredients
  validates_presence_of :instructions
  validates_presence_of :url

  def self.newyorktimes(page_number)
    url = ENV["API_NYTIMES"] + '?api-key=' + ENV["API_KEY_NYT"]

    query_params = "&fq=document_type:(\"recipe\")" + '&page=' + page_number

    response = HTTParty.get(url + query_params)
    @result = JSON.parse(response.body)
    @result
  end

  def self.scrape_for_recipe(url)
    doc = Nokogiri::HTML(open(url))
    #doc.css('.recipe-instructions')
  end

  def self.scrape_ingredients(noko_doc)
    doc = noko_doc.css('.recipe-ingredients')
    nutrition_facts = doc.at_css('div.nutrition-container')
    if nutrition_facts
      nutrition_facts.parent.remove
    end
    doc
  end

  def self.scrape_instructions(noko_doc)
    noko_doc.css('.recipe-steps')
  end
end
