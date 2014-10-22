class Comment < ActiveRecord::Base
	attr_accessible :content, :prod_return_id, :user_id
  
	belongs_to :prod_return
	belongs_to :user

	default_scope order: 'comments.created_at DESC'

	validates :user_id, :prod_return_id, :content, presence: true
	validates :content, length: { maximum: 200 }
end
