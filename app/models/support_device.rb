class SupportDevice < ApplicationRecord
  belongs_to :package
  belongs_to :device
end
