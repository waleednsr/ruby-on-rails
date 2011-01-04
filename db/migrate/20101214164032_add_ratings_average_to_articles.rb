class AddRatingsAverageToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :rating_average, :decimal
  end

  def self.down
    remove_column :articles, :rating_average
  end
end
