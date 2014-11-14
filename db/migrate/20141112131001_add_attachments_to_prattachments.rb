class AddAttachmentsToPrattachments < ActiveRecord::Migration
  def self.up
      add_attachment :prattachments, :pr_file
  end

  def self.down
    remove_attachment :prattachments, :pr_file
  end
end
