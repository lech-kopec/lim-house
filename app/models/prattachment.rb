class Prattachment < ActiveRecord::Base
  attr_accessible :pr_file

  belongs_to :prodreturn

  has_attached_file :pr_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "rails.png"
  validates_attachment :pr_file, content_type: { content_type: ["application/pdf", /\Aimage\/.*\Z/] }

end
