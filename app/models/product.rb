class Product < ActiveRecord::Base
  attr_accessible :amazon_url, :asin, :average_rating, :name, :picture_url, :price,
  :amazon_last_updated, :price_too_low, :oos, :reviewed_or_questioned, :product_group,
  :description, :total_stars

  default_scope where(:reviewed_or_questioned => true)

  monetize :price_cents

  has_many :reviews, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :similars, :dependent => :destroy
  has_many :similar_products, :through => :similars
  has_many :alerts, :as => :alertable, :dependent => :destroy

end
