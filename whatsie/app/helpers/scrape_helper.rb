module ScrapeHelper
  def scrape_this(url)
    Recipe.scrape_for_recipe(url)
  end

  def scrape_ny_ingredients(noko_doc)
    Recipe.scrape_ingredients(noko_doc)
  end

  def scrape_ny_instructions(noko_doc)
    Recipe.scrape_instructions(noko_doc)
  end

  def noko_to_s(noko_doc)
    noko_doc.to_s.gsub(/"/, '\'')
  end

  def save_recipe(recipe_info)
    Recipe.create(recipe_info)
  end
end
