class Group < ApplicationRecord
  has_many :players
  has_many :csv_files
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Group.find_or_create_by!(group_name: row[1])
    end
  end
end
