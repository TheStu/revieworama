class Similar < ActiveRecord::Base
  attr_accessible :asin, :in_database, :product_id

  belongs_to :product
  has_many :similar_products,
           :foreign_key => :asin,
           :primary_key => :asin,
           :class_name => 'Product'
end
