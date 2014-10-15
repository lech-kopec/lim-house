class Client < ActiveRecord::Base
  attr_accessible :address, :f_name, :l_name
  has_many :transactions

  validates :address, :f_name, :l_name, presence: true
  validates :address, :f_name, :l_name, length: { maximum: 50 }
end
