class AddAttachmentContentToArailImages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :arail_images do |t|
      t.attachment :content
    end
  end

  def self.down
    remove_attachment :arail_images, :content
  end
end
