class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user
  validates :rating, presence: true
  validates_numericality_of :rating, :greater_than_or_equal_to => 1.0, :less_than_or_equal_to => 5.0
end
