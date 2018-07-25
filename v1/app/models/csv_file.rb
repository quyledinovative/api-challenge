class CsvFile < ApplicationRecord
  belongs_to :group
  belongs_to :match
  belongs_to :player
  belongs_to :venue
  belongs_to :player_match
  def self.import(file)

    t = Tournament.find_or_create_by!(tournament_name: File.basename(file.original_filename, '.csv'), tournament_description: 'No Description')
    CSV.foreach(file.path, headers: true) do |row|
      g = Group.find_or_create_by!(group_name: row['group'])
      p1 = Player.find_or_create_by!(player_name: row['player 1'], group: g)
      p2 = Player.find_or_create_by!(player_name: row['player 2'], group: g)
      v = Venue.find_or_create_by!(venue_name: row['venue'])
      m = Match.find_or_create_by!(match_code: row['match code'], match_time: row['time'], match_date: row['date'], venue: v, tournament: t)
      id1 = p1
      id2 = p2
      score_p1 = 0
      score_p2 = 0
      result_p1 = 'Lose'
      result_p2 = 'Win'
      if row['score'].to_s.include?" gave up"
        if row['score'].to_s.split(" gave up")[0].strip == p1.player_name
          score_p1 = 0
          score_p2 = 3
        else
          id1 = p2
          id2 = p1
          score_p1 = 3
          score_p2 = 0
          result_p1 = 'Win'
          result_p2 = 'Lose'
        end
      else
        array_score = row['score'].to_s.split('-')
        # score_p1 = array_score[0]
        # score_p2 = array_score[1]
        if array_score[0] > array_score[1]
          score_p1 = 3
          score_p2 = 0
          result_p1 = 'Win'
          result_p2 = 'Lose'
        elsif array_score[0] < array_score[1]
          score_p1 = 0
          score_p2 = 3
          result_p1 = 'Lose'
          result_p2 = 'Win'
        elsif array_score[0] == array_score[1]
          score_p1 = 1
          score_p2 = 1
          result_p1 = 'Draw'
          result_p2 = 'Draw'
        end
      end
      p_m_1 = PlayerMatch.find_or_create_by!(player: id1, match: m, score: score_p1, result: result_p1)
      p_m_2 = PlayerMatch.find_or_create_by!(player: id2, match: m, score: score_p2, result: result_p2)
    end
  end
end
