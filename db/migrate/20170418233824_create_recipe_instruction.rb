class CreateRecipeInstruction < ActiveRecord::Migration[5.0]
  def change
    create_table :recipe_instructions do |t|
      t.string :instruction, null: false
      t.integer :order, null: false

      t.timestamps null: false
    end
  end
end
