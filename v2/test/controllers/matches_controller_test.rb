require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match = matches(:one)
  end

  test "should get index" do
    get matches_url, as: :json
    assert_response :success
  end

  test "should create match" do
    assert_difference('Match.count') do
      post matches_url, params: { match: { code: @match.code, date: @match.date, player1_id: @match.player1_id, player2_id: @match.player2_id, score1: @match.score1, score2: @match.score2, time: @match.time, tournament_id: @match.tournament_id, venue_id: @match.venue_id } }, as: :json
    end

    assert_response 201
  end

  test "should show match" do
    get match_url(@match), as: :json
    assert_response :success
  end

  test "should update match" do
    patch match_url(@match), params: { match: { code: @match.code, date: @match.date, player1_id: @match.player1_id, player2_id: @match.player2_id, score1: @match.score1, score2: @match.score2, time: @match.time, tournament_id: @match.tournament_id, venue_id: @match.venue_id } }, as: :json
    assert_response 200
  end

  test "should destroy match" do
    assert_difference('Match.count', -1) do
      delete match_url(@match), as: :json
    end

    assert_response 204
  end
end
