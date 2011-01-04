class CreateMp3s < ActiveRecord::Migration
  def self.up
    create_table :mp3s do |t|
      t.string :name
      t.string :singer
      t.decimal :length
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :mp3s
  end
end
