class AddAttachmentsImageToMp3 < ActiveRecord::Migration
  def self.up

    add_column :mp3s, :image_file_name, :string
    add_column :mp3s, :image_content_type, :string
    add_column :mp3s, :image_file_size, :integer
    add_column :mp3s, :image_updated_at, :datetime

  end

  def self.down

    remove_column :mp3s, :image_file_name
    remove_column :mp3s, :image_content_type
    remove_column :mp3s, :image_file_size
    remove_column :mp3s, :image_updated_at

  end
end
