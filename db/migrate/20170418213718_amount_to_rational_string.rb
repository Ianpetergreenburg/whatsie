class AmountToRationalString < ActiveRecord::Migration[5.0]
  def change
    change_column :recipe_ingredients, :amount, :string
  end
end
