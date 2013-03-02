class Question < ActiveRecord::Base
  attr_accessible :content, :product_id, :title, :user_id

  has_many :alerts, :as => :alertable, :dependent => :destroy
  has_many :votes, :as => :votable, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  belongs_to :product
  belongs_to :user

  after_create :set_product_to_active
  after_destroy :check_and_set_to_inactive

  private

  def set_product_to_active
    Product.unscoped do
      self.product.update_attributes(:reviewed_or_questioned => true)
    end
  end

  def check_and_set_to_inactive
    if self.product.reviews.count == 0 && self.product.questions.count == 0
      self.product.update_attributes(:reviewed_or_questioned => false)
    end
  end
end
