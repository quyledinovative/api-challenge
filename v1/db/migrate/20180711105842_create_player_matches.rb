class CreatePlayerMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :player_matches do |t|
      t.references :player, foreign_key: true
      t.references :match, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
