class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :product_id
      t.string :alertable_type
      t.integer :alertable_id
      t.integer :user_id

      t.timestamps
    end
    add_index :alerts, [:product_id, :alertable_id]
    add_index :alerts, [:alertable_type, :user_id]
  end
end
