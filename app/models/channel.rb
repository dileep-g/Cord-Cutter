class Channel < ApplicationRecord
  # Relationship - antenna
  has_many :antennas

  # Relationship - preferences
  has_many :perferences

  # Relationship - packages provide
  has_many :provide_channels

  # Validation - name
  validates(:name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true)
end
