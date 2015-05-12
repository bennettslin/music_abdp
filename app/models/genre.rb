class Genre < ActiveRecord::Base

  has_and_belongs_to_many :users
  has_many :songs

  validates :name,
    presence: true

end
