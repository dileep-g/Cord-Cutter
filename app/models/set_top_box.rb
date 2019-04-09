class SetTopBox < ApplicationRecord
  # Relationship - user own boxes
  has_many :own_boxes

  # Relationship - package support box
  has_many :support_boxes

  # Validation - name
  validates(:name, presence: true, length: { minimum: 1, maximum: 255}, uniqueness: true)
end
