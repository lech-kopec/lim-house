class ProdReturn < ActiveRecord::Base
  attr_accessible :auction_date, :auction_name, :client_msg, :client_name, :status

  belongs_to :user
  has_many :comments

  default_scope order: 'prod_returns.created_at DESC'

  validates :auction_date, :auction_name, :client_name, :status, presence: true
  validates :auction_name, :client_name, length: { maximum: 50 }
  validates :client_msg, length: { maximum: 2000 }
end
