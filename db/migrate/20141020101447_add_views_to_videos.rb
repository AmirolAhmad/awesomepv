class AddViewsToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :views, :integer unless column_exists? :videos, :views
  end

  def down
    remove_column :videos, :views if column_exists? :videos, :views
  end
end
