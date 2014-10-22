class CreatePictures < ActiveRecord::Migration
  def up
    create_table :pictures do |t|
      t.integer :user_id, null: false
      t.string :pid
      t.string :title
      t.text :content
      t.string :cover_photo
      t.boolean :featured
      t.string :slug
      t.string :state
      t.datetime :published_at
      t.integer :views

      t.timestamps
    end
  end

  def down
    drop_table :pictures if table_exists? :pictures
  end
end
