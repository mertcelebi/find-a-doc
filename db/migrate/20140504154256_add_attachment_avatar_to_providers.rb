class AddAttachmentAvatarToProviders < ActiveRecord::Migration
  def self.up
    change_table :providers do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :providers, :avatar
  end
end
