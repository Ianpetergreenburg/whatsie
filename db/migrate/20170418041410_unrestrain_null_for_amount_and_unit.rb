class UnrestrainNullForAmountAndUnit < ActiveRecord::Migration[5.0]
  def change
    change_column :recipe_ingredients, :unit, :string, null: true
    change_column :recipe_ingredients, :amount, :integer, null: true
  end
end
