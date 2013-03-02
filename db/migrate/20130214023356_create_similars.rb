class CreateSimilars < ActiveRecord::Migration
  def change
    create_table :similars do |t|
      t.integer :product_id
      t.string :asin
      t.boolean :in_database

      t.timestamps
    end
    add_index :similars, :product_id
  end
end
