class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :product_id
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :questions, [:user_id, :product_id]
  end
end
