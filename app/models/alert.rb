class Alert < ActiveRecord::Base
  attr_accessible :alertable_id, :alertable_type, :product_id, :user_id

  belongs_to :alertable, :polymorphic => true
  belongs_to :product
  belongs_to :user
end
