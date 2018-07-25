class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :code
      t.time :time
      t.date :date
      t.references :player1
      t.references :player2
      t.integer :score1
      t.integer :score2
      t.references :venue, foreign_key: true
      t.references :tournament, foreign_key: true

      t.timestamps
    end
  end
end
