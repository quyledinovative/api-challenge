class Api::V2::Tournament < ApplicationRecord
  has_many :matches
end
