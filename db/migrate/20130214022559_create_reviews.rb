class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :reviews, [:user_id, :product_id]
  end
end
