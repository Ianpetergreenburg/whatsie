class PlausibleUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :plausible_urls do |t|
      t.string :source, null: false
      t.integer :recipe_id, null: false

      t.timestamps null: false
    end

    add_index :plausible_urls, [ :source, :recipe_id ], :unique => true
  end
end
