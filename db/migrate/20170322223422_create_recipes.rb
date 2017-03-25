class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :name, null: false
      t.string :ingredients, null: false
      t.string :instructions, null: false
      t.string :url, null: false
      t.string :image_url

      t.timestamps null: false
    end
  end
end
