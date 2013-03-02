class Review < ActiveRecord::Base
  attr_accessible :content, :title, :stars

  has_many :alerts, :as => :alertable, :dependent => :destroy
  has_many :votes, :as => :votable, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  belongs_to :product
  belongs_to :user

  after_create :set_product_to_active
  after_save :update_product_stars

  after_destroy :check_and_set_to_inactive
  after_destroy :update_product_stars

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

  def update_product_stars
    total = self.product.reviews.sum('stars')
    ratings = self.product.reviews.count
    ratings == 0 ? average = 0 : average = total / ratings.to_f
    self.product.update_attributes( :average_rating => average,
                                    :total_stars => ratings)
  end
end
