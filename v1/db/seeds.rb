# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'csv'
#
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'tournament_9_ball.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
# csv.each do |row|
#   puts row.to_hash
#     g = Group.find_or_create_by(group_name: row['group'])
#     p1 = Player.find_or_create_by(player_name: row['player 1'], group: g.group_name)
#     p2 = Player.find_or_create_by(player_name: row['player 2'], group: g.group_name)
#     v = Venue.find_or_create_by(venue_name: row['venue'])
#     m = Match.find_or_create_by(match_code: row['match code'], time: row['time'], date: row['date'])
#     id1 = ''
#     id2 = ''
#     score_p1 = 0
#     score_p2 = 0
#     if row['score'].to_s.include?" gave up"
#       if row['score'].to_s.split!(" gave up").strip! == p1.player_name
#         id1 = p1.player_id.to_s
#         id2 = p2.player_id.to_s
#         score_p1 = 0
#         score_p2 = 3
#       else
#         id1 = p2.player_id.to_s
#         id2 = p1.player_id.to_s
#         score_p1 = 3
#         score_p2 = 0
#       end
#     else
#       array_score = row['score'].to_s.split!('-')
#       score_p1 = array_score[0]
#       score_p2 = array_score[1]
#     end
#     p_m_1 = PlayerMatch.find_or_create_by(player: id1, match: m.match_id, score: score_p1)
#     p_m_2 = PlayerMatch.find_or_create_by(player: id2, match: m.match_id, score: score_p2)
# end
#
# puts "They're all done successfully"
