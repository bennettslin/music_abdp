class Song < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :genre

  has_many :quiz_takers, class_name: "User"

  validates :itunes_id,
    presence: true
end