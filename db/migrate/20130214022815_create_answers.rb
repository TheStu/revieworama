class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :question_id
      t.text :content

      t.timestamps
    end
    add_index :answers, [:user_id, :product_id, :question_id]
  end
end
