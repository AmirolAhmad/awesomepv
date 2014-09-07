class AddFeaturedToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :featured, :boolean unless column_exists? :posts, :featured
  end

  def down
  	remove_column :posts, :featured if column_exists? :posts, :featured
  end
end
