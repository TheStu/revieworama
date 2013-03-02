class AddColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :amazon_last_updated, :timestamp
  end
end
