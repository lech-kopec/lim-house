class Prattachment < ActiveRecord::Base
  attr_accessible :pr_file

  belongs_to :prodreturn

  has_attached_file :pr_file, :storage=> :ftp, :path => "/lim-trade-reklamacje/:attachment/:id/:style/:filename", :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "rails.png",
  					:ftp_servers => [
										{
										:host     => "fire.dhosting.pl",
										:user     => "limtrade",
										:password => "Kwidzyn87800",
										:passive => true
										}
									]
  validates_attachment :pr_file, content_type: { content_type: ["application/pdf", /\Aimage\/.*\Z/] }

end
