class AddToProducts < ActiveRecord::Migration
  def change
    add_column :products, :price_too_low, :boolean
    add_column :products, :oos, :boolean, default: false
    add_column :products, :reviewed_or_questioned, :boolean, default: false
    add_column :products, :product_group, :string
    add_column :products, :description, :text
    remove_column :similars, :in_database
    rename_column :products, :price, :price_cents
    add_index :products, :reviewed_or_questioned
  end
end
