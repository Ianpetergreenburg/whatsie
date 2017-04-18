require 'json'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'nori'

class NytRecipeScraperService
  attr_reader :doc, :recipe_url
  def initialize(recipe_url)
    @doc = NytRecipeScraperService.scrape_for_recipe recipe_url
    @recipe_url = recipe_url
    create_recipe
    @recipe.load_ingredients ingredients
    return @recipe
  end

  def get_recipe
    return {
      name: name,
      url: @recipe_url,
      instructions: instructions,
      image_url: image_url
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
    @recipe = Recipe.create(get_recipe)
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
    @doc.css('.recipe-steps')
  end
end
