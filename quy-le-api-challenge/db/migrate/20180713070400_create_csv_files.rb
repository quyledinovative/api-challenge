class CreateCsvFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :csv_files do |t|
      t.references :group, foreign_key: true
      t.references :match, foreign_key: true
      t.references :player, foreign_key: true
      t.references :venue, foreign_key: true
      t.references :player_match, foreign_key: true

      t.timestamps
    end
  end
end
