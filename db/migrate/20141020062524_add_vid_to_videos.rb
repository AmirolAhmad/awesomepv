class AddVidToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :vid, :string unless column_exists? :videos, :vid
  end

  def down
    remove_column :videos, :vid if column_exists? :videos, :vid
  end
end