class PlayerMatch < ApplicationRecord
  belongs_to :player
  belongs_to :match
  has_many :csv_files
end
