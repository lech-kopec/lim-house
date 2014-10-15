class Transaction < ActiveRecord::Base
  attr_accessible :auction_id, :quantity, :status
  belongs_to :auction
  belongs_to :client

  validates :client_id, :auction_id, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :status, inclusion: { in: TransactionsHelper::Status.values }
end
