class Auction < ActiveRecord::Base
  attr_accessible :title, :description, :price, :quantity, :status, :store
  belongs_to :product
  has_many :transactions

  validates :product_id, :title, :description, :price, :quantity, :status, :store, presence: true
  validates :title, length: {maximum: 50}
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
  validates :store, inclusion: { in: AuctionsHelper::Stores.values }
end
