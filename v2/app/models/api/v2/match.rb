class Api::V2::Match < ApplicationRecord
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  belongs_to :venue
  belongs_to :tournament
  scope :filter_by_player_name, -> (player_name) {
    joins(:player1, :player2, :tournament).where(players: {name: player_name})
  }
  scope :filter_by_tournament_name, -> (tournament_name) {
    joins(:player1, :player2, :tournament).where(tournaments: {name: tournament_name})
  }
  scope :show_player_result, -> (temp) {
    PLayer_Result = {
      Total_Points: joins(:player1).where(players: {name: temp}).sum(:score1) + joins(:player2).where(players: {name: temp}).where(score2: 0).sum(:score2),
      Number_of_Won_Matches: joins(:player1).where(players: {name: temp}).where(score1: 3).count + joins(:player2).where(players: {name: temp}).where(score2: 3).count,
      Number_of_Lost_Matches: joins(:player1).where(players: {name: temp}).where(score1: 0).count + joins(:player2).where(players: {name: temp}).where(score1: 0).count,
      Number_of_Drawn_Matches: joins(:player1).where(players: {name: temp}).where(score1: 1).count + joins(:player2).where(players: {name: temp}).where(score1: 1).count,
    }
  }
  def self.import(file)
    t = Tournament.find_or_create_by!(name: File.basename(file.original_filename, '.csv'), description: 'No Description')
    CSV.foreach(file.path, headers: true) do |row|
      g = Group.find_or_create_by!(name: row['group'])
      p1 = Player.find_or_create_by!(name: row['player 1'], group: g)
      p2 = Player.find_or_create_by!(name: row['player 2'], group: g)
      v = Venue.find_or_create_by!(name: row['venue'])
      score_p1 = 0
      score_p2 = 0
      if row['score'].to_s.include?" gave up"
        if row['score'].to_s.split(" gave up")[0].strip == p1.name
          score_p1 = 0
          score_p2 = 3
        else
          score_p1 = 3
          score_p2 = 0
        end
      else
        array_score = row['score'].to_s.split('-')
        if array_score[0] > array_score[1]
          score_p1 = 3
          score_p2 = 0
        elsif array_score[0] < array_score[1]
          score_p1 = 0
          score_p2 = 3
        elsif array_score[0] == array_score[1]
          score_p1 = 1
          score_p2 = 1
        end
      end
      m = Match.find_or_create_by!(code: row['match code'], time: row['time'], date: row['date'], player1: p1, player2: p2, venue: v, tournament: t, score1: score_p1, score2: score_p2)
    end
  end
end
