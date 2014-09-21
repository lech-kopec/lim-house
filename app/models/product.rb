class Product < ActiveRecord::Base
  attr_accessible :description, :price, :status, :title, :quantity

  validates :title, :description, :price, :status, :quantity, presence: true
  validates :title, length: {maximum: 50}
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
