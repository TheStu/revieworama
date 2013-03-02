class Answer < ActiveRecord::Base
  attr_accessible :content, :product_id, :user_id, :question_id

  has_many :votes, :as => :votable, :dependent => :destroy
  belongs_to :question
  belongs_to :user
  belongs_to :product
end
