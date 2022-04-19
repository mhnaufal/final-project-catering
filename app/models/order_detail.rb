class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :menu

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :menu_price, presence: true, numericality: true
end
