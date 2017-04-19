class CreateRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_ingredients do |t|
      t.belongs_to :recipe
      t.belongs_to :ingredient
      t.integer :amount, null: false
      t.string :unit, null: false

      t.timestamps null: false
    end
  end
end
