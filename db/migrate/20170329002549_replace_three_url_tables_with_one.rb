class ReplaceThreeUrlTablesWithOne < ActiveRecord::Migration[5.0]
  def change
    drop_table :plausible_urls
    drop_table :implausible_urls
    drop_table :scraped_urls
    create_table :recipe_urls do |t|
      t.string :source, null: false
      t.integer :recipe_id, null: false
      t.boolean :plausible, null: false
      t.boolean :scraped, null: false

      t.timestamps null: false
    end

    add_index :recipe_urls, [ :source, :recipe_id ], :unique => true
  end
end
