class CreateRecipeBooks < ActiveRecord::Migration
  def change
    create_table :recipe_books do |t|
      t.belongs_to :recipe, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
