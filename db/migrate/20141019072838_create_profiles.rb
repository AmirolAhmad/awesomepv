class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :full_name
      t.string :facebook_id

      t.timestamps
    end
  end
end
