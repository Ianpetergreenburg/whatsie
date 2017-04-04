class AddUrlToRecipeUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :recipe_urls, :url, :string, null: false, default: 'url'
  end
end
