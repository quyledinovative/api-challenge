class Player < ApplicationRecord
  belongs_to :group
  has_many :csv_files
  has_many :player_matches
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      g = Group.find_or_create_by(group_name = row[1])
      Player.find_or_create_by!(player_name: row[3], group: g.group_id)
      Player.find_or_create_by!(player_name: row[4], group: g.group_id)
    end
  end
end
