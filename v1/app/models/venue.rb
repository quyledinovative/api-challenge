class Venue < ApplicationRecord
  has_many :matchs
  has_many :csv_files
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Venue.find_or_create_by!(venue_name: row[7])
    end
  end
end
