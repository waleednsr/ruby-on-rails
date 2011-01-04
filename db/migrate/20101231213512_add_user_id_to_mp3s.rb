class AddUserIdToMp3s < ActiveRecord::Migration
  def self.up
    add_column :mp3s, :user_id, :integer
  end

  def self.down
    remove_column :mp3s, :user_id
  end
end
