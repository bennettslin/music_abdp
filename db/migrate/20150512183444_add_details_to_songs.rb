class AddDetailsToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :spotify_id, :string
    remove_column :songs, :primary_genre, :string
    remove_column :songs, :year, :integer
    add_column :songs, :image_url, :string
    add_column :songs, :preview_url, :string
  end
end
