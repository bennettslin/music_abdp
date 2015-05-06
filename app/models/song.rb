class Song < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :itunes_id,
    presence: true
end
