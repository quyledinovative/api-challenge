class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.string :match_code
      t.time :match_time
      t.date :match_date
      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
