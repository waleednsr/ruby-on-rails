class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :name
      t.text :description
      t.string :author
      t.date :published_at
      t.string   :photo_file_name
      t.string   :photo_content_type
      t.integer  :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
