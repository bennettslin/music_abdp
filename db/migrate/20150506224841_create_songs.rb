class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :itunes_id
      t.string :title
      t.string :artist
      t.string :album
      t.integer :year
      t.string :primary_genre

      t.timestamps null: false
    end
  end
end
