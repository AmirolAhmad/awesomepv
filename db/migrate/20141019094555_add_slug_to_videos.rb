class AddSlugToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :slug, :string unless column_exists? :videos, :slug
  end

  def down
    remove_column :videos, :slug if column_exists? :videos, :slug
  end
end
