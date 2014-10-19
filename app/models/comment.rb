class Comment < ActiveRecord::Base
	attr_accessible :content, :prod_return_id, :user_id
  
	belongs_to :prod_return
	belongs_to :user

	default_scope order: 'comments.created_at DESC'
end
