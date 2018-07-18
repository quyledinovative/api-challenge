class AddResultToPlayerMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :player_matches, :result, :string
  end
end
