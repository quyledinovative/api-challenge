class Api::V2::Player < ApplicationRecord
  belongs_to :group
  has_many :player1_matches, class_name: 'Match', foreign_key: 'player1_id'
  has_many :player2_matches, class_name: 'Match', foreign_key: 'player2_id'
end
