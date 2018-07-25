class Match < ApplicationRecord
  belongs_to :venue
  belongs_to :tournament
  has_many :csv_files
  has_many :player_matches
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Venue.find_or_create_by!(venue_name: row[7])
      Match.find_or_create_by!(match_code: row[2], time: row[5], date: row[6], venue: v.venue_id)
    end
  end
end
