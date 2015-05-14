class RemoveSpotifyIdFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :spotify_id, :string
  end
end
