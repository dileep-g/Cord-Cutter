class Perference < ApplicationRecord
  belongs_to :user
  belongs_to :channel

  validates(:rate, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 3})
end
