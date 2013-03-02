class Comment < ActiveRecord::Base
  attr_accessible :content, :product_id, :user_id, :review_id

  belongs_to :review
  belongs_to :user
  belongs_to :product
end
