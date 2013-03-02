class AddStarsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :stars, :integer
    add_column :products, :total_stars, :integer
  end
end
