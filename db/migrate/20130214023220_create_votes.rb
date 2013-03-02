class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :votable_id
      t.string :votable_type
      t.integer :user_id
      t.boolean :voted

      t.timestamps
    end
    add_index :votes, [:votable_type, :votable_id, :user_id]
  end
end
