class AddValueNumberToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :value, :integer
  end
end
