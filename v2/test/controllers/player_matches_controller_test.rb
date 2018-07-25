require 'test_helper'

class PlayerMatchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player_match = player_matches(:one)
  end

  test "should get index" do
    get player_matches_url, as: :json
    assert_response :success
  end

  test "should create player_match" do
    assert_difference('PlayerMatch.count') do
      post player_matches_url, params: { player_match: { match_id: @player_match.match_id, player_id: @player_match.player_id, result: @player_match.result, score: @player_match.score } }, as: :json
    end

    assert_response 201
  end

  test "should show player_match" do
    get player_match_url(@player_match), as: :json
    assert_response :success
  end

  test "should update player_match" do
    patch player_match_url(@player_match), params: { player_match: { match_id: @player_match.match_id, player_id: @player_match.player_id, result: @player_match.result, score: @player_match.score } }, as: :json
    assert_response 200
  end

  test "should destroy player_match" do
    assert_difference('PlayerMatch.count', -1) do
      delete player_match_url(@player_match), as: :json
    end

    assert_response 204
  end
end
