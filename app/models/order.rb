class Order < ApplicationRecord
  belongs_to :user
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :total, presence: true
  has_many :products, through: :placements 
  before_validation :set_total!

  def set_total!
    self.total = products.map(&:price).sum
  end
end
