class ProdReturn < ActiveRecord::Base
	attr_accessible :auction_date, :auction_name, :client_msg, :client_name, :status

	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :prattachments, dependent: :destroy

	default_scope order: 'prod_returns.created_at DESC'

	validates :user_id, :auction_date, :auction_name, :client_name, :status, presence: true
	validates :auction_name, :client_name, length: { maximum: 50 }
	validate :auction_date_cannot_be_in_future
	validates :status, inclusion: { in: ApplicationHelper::ReturnsStatus.values }


	def auction_date_cannot_be_in_future
		if auction_date.present? && auction_date > Date.current
			errors.add(:auction_date, "cannot be set in future")
		end
	end

	def self.gen_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end
end
