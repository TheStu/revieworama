class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :asin, :unique => true
      t.string :picture_url
      t.string :amazon_url
      t.string :name
      t.integer :price
      t.decimal :average_rating, :default => 0

      t.timestamps
    end
    add_index :products, :asin
  end
end
