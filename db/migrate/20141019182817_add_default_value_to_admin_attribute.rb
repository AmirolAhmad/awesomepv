class AddDefaultValueToAdminAttribute < ActiveRecord::Migration
  def up
  	change_column :users, :admin, :boolean, :default => false
  end

  def down  	
  end
end
