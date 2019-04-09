class ProvideChannel < ApplicationRecord
  belongs_to :package
  belongs_to :channel
end
