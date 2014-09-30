class Product < ActiveRecord::Base
  attr_accessible :description, :price, :status, :title, :quantity, :image_lnk
  has_many :auctions

  validates :title, :description, :price, :status, :quantity, presence: true
  validates :title, length: {maximum: 50}
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
  validates :status, :numericality => { only_integer: true, :greater_than => 0, :less_than => ProductsHelper::Product_status.length+1 }
end
