class User < ActiveRecord::Base
  has_secure_password

  has_and_belongs_to_many :genres
  has_and_belongs_to_many :songs

  belongs_to :quiz_song, class_name: "Song", foreign_key: "quiz_song_id"

  validates :first_name,
  presence: true

  validates :last_name,
  presence: true

  validates :email,
    presence: true

  validates :password,
    presence: true,
    :on => :create

  validates :genres,
    presence: true,
    :on => :update


  def self.authenticate email, password
    User.find_by_email(email).try(:authenticate, password)
  end

    # for mailer
  def set_password_reset
    self.code = SecureRandom.urlsafe_base64
    self.expires_at = 4.hours.from_now
    self.save
  end
end
