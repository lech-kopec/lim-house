class Comment < ActiveRecord::Base
	attr_accessible :content, :prod_return_id, :user_id
  
	belongs_to :prod_return
	belongs_to :user

	default_scope order: 'comments.created_at DESC'

	validates :user_id, :prod_return_id, :content, presence: true
	validates :content, length: { maximum: 200 }

	def self.gen_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |product|
				csv << product.attributes.values_at(*column_names)
			end
		end
	end
	
end
