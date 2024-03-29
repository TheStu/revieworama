class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :review_id
      t.text :content

      t.timestamps
    end
    add_index :comments, [:user_id, :product_id, :review_id]
  end
end
