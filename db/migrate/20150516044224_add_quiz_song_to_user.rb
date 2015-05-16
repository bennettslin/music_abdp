class AddQuizSongToUser < ActiveRecord::Migration
  def change
    add_column :users, :quiz_song_id, :integer
  end
end
