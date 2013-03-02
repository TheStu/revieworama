class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  :name, :amazon_tag
  # attr_accessible :title, :body

  has_many :products, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :questions, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :answers, :dependent => :destroy
  has_many :alerts, :dependent => :destroy
  has_many :votes, :dependent => :destroy

  validate :three_reviews_for_amazon_tag

  private

  def three_reviews_for_amazon_tag
    if amazon_tag.present? and self.reviews.count < 3
      errors.add(:amazon_tag, "can't be entered until you've created three reviews.")
    end
  end
end
