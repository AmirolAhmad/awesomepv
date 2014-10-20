class AddStateToVideos < ActiveRecord::Migration
  def up
    add_column :videos, :state, :string unless column_exists? :videos, :state
  end

  def down
    remove_column :videos, :state if column_exists? :videos, :state
  end
end
