class Song < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :genre

  validates :spotify_id,
    presence: true
end
