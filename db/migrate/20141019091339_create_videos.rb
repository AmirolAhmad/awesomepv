class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.integer :user_id, null: false
      t.string :title
      t.text :description
      t.string :source
      t.string :youtube_id
      t.boolean :featured

      t.timestamps
    end
  end

  def down
    drop_table :videos if table_exists? :videos
  end
end
