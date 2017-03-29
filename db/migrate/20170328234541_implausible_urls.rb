class ImplausibleUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :implausible_urls do |t|
      t.string :source, null: false
      t.integer :recipe_id, null: false

      t.timestamps null: false
    end

    add_index :implausible_urls, [ :source, :recipe_id ], :unique => true
  end
end
