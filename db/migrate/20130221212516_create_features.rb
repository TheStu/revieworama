class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :product_id
      t.string :content

      t.timestamps
    end
    add_index :features, :product_id
  end
end
