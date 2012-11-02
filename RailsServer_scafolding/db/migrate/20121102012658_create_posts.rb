class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :song_id
      t.date :date

      t.timestamps
    end
  end
end
