class Device < ApplicationRecord
  # Relationship - user own devices
  has_many :own_devices

  # Relationship - package support devices
  has_many :support_devices

  # Validation - name
  validates(:name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true)
end
