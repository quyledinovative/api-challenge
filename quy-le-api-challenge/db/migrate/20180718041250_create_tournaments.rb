class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :tournament_name
      t.string :tournament_description

      t.timestamps
    end
  end
end
