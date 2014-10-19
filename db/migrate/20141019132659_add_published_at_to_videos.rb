class AddPublishedAtToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :published_at, :datetime unless column_exists? :videos, :published_at
  end

  def down
    remove_column :videos, :published_at if column_exists? :videos, :published_at
  end
end
