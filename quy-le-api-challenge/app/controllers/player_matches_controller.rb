class PlayerMatchesController < ApplicationController
  before_action :set_player_match, only: [:show, :update, :destroy]

  # GET /player_matches
  def index
    @player_matches = PlayerMatch.all

    render json: @player_matches
  end

  # GET /player_matches/1
  def show
    render json: @player_match
  end

  # POST /player_matches
  def create
    @player_match = PlayerMatch.new(player_match_params)

    if @player_match.save
      render json: @player_match, status: :created, location: @player_match
    else
      render json: @player_match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /player_matches/1
  def update
    if @player_match.update(player_match_params)
      render json: @player_match
    else
      render json: @player_match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /player_matches/1
  def destroy
    @player_match.destroy
  end
  def show_points
    @new_hash = {'Player Name' => params[:player_name],
                     'Total Points'=> PlayerMatch.joins(:player, :match)
                                          .where("players.player_name" => params[:player_name])
                                          .sum(:score),
                     'Number of Won Matches'=> PlayerMatch.joins(:player, :match)
                                                   .where("players.player_name" => params[:player_name]).where("player_matches.result" => 'Win')
                                                   .count(:result),
                     'Number of Lost Matches'=> PlayerMatch.joins(:player, :match)
                                                    .where("players.player_name" => params[:player_name]).where("player_matches.result" => 'Lose')
                                                    .count(:result),
                     'Number of Drawn Matches'=> PlayerMatch.joins(:player, :match)
                                                     .where("players.player_name" => params[:player_name]).where("player_matches.result" => 'Draw')
                                                     .count(:result)}

    render json:@new_hash
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_match
      @player_match = PlayerMatch.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def player_match_params
      params.require(:player_match).permit(:player_id, :match_id, :score)
    end
end
