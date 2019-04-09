class User < ApplicationRecord
  # Relationship - antenna
  has_many :antennas
  has_many :channels, through: :antennas

  # Relationship - own boxes
  has_many :own_boxes
  has_many :set_top_boxes, through: :own_boxes

  # Relationship - own devices
  has_many :own_devices
  has_many :devices, through: :own_devices

  # Relationship - preference
  has_many :perferences
  has_many :channels, through: :perferences

  # Validation email
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates(:email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }, allow_nil: true)

  # Password set
  has_secure_password
  validates(:password, presence: true, length: { minimum: 6 })

  attr_accessor :remember_token

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_antenna(channel_ids)
    if channel_ids
      channel_ids.each do |id|
        self.antennas.create channel_id: id 
      end
    end
  end

end
