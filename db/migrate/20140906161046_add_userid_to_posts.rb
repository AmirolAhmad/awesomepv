class AddUseridToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :user_id, :integer unless column_exists? :posts, :user_id
  end

  def down
  	remove_column :posts, :user_id if column_exists? :posts, :user_id
  end
end
