class Sale < ActiveRecord::Base
	attr_accessible :title, :price, :quantity, :status

	validates :title, :price, :quantity, :status, presence: true
	validates :title, length: { maximum: 150 }
	validates :price, numericality: {:greater_than => 0}
	validates :quantity, numericality: {:greater_than => 0, only_integer: true }
	validates :status, inclusion: { in: ApplicationHelper::SaleStatus.values }
end
