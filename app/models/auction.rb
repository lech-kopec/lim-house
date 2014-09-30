class Auction < ActiveRecord::Base
  attr_accessible :quantity, :status, :store
  belongs_to :product

  validates :product_id, :quantity, :status, :store, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :store, inclusion: { in: AuctionsHelper::Stores.values }
end
