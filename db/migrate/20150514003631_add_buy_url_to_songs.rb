class AddBuyUrlToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :buy_url, :string
  end
end
