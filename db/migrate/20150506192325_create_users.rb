class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :provider
      t.string :provider_id
      t.string :provider_hash
      t.integer :genre_preference

      t.timestamps null: false
    end
  end
end
