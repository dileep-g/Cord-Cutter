class Package < ApplicationRecord
  # Relationship - provide channels
  has_many :provide_channels
  has_many :channels, through: :provide_channels

  # Relationship - support boxes
  has_many :support_boxes
  has_many :set_top_boxes, through: :support_boxes

  # Relationship - support devices
  has_many :support_devices
  has_many :devices, through: :support_devices

  # Validation - name
  VALID_HTTPS_LINK = /https:\/\//
  validates(:name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true)
  validates(:cost, presence: true)
  validates(:link, format: { with: VALID_HTTPS_LINK })
end
