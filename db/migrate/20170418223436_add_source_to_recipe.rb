class AddSourceToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :source, :string
  end
end
