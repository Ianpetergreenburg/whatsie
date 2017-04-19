require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'nori'

class NytRecipeScraperService
  attr_reader :doc, :recipe_url, :recipe
  def initialize(recipe_url)
    @doc = NytRecipeScraperService.scrape_for_recipe recipe_url
    @recipe_url = recipe_url
    @recipe = create_recipe
    @recipe.load_ingredients ingredients
    @recipe.load_instructions instructions
  end

  def get_recipe
    return {
      name: name,
      url: @recipe_url,
      image_url: image_url,
      source: 'New York Times Cooking'
    }
  end

  def self.scrape_for_recipe(url)
    doc = Nokogiri::HTML(open(url))
  end

  def self.api_call(page_number)
    url = ENV["API_NYTIMES"] + '?api-key=' + ENV["API_KEY_NYT"]

    query_params = "&fq=document_type:(\"recipe\")" + '&page=' + page_number

    response = HTTParty.get(url + query_params)
    @result = JSON.parse(response.body)
    @result
  end

  private
  def create_recipe
    Recipe.create(get_recipe)
  end

  def name
    @doc.at_css('.recipe-title').text.gsub("\n", '').strip
  end

  def image_url
    images = @doc.css('.media-container img')
    if images.empty?
      ''
    else
      images.attr('src').text
    end
  end


  def ingredients
    doc = @doc.css('.recipe-ingredients')
    nutrition_facts = doc.at_css('div.nutrition-container')
    if nutrition_facts
      nutrition_facts.parent.remove
    end
    ingredients = doc.css('li').map {|li| li.text.gsub(/\\n/, ' ').gsub(/\s+/, ' ').strip}
    ingredients.map! do |ing|
      begin
        Ingreedy.parse ing
      rescue
        ing
      end
    end

    ingredients
  end

  def instructions
    instructions = @doc.css('.recipe-steps')
    instructions.css('li').map {|li| li.text.gsub(/\\n/, ' ').gsub(/\s+/, ' ').strip}
  end
end
