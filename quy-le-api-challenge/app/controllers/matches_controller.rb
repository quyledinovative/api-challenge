class MatchesController < ApplicationController
  before_action :set_match, only: [:show, :update, :destroy]

  # GET /matches
  def index
    @matches = Match.all

    render json: @matches
  end

  # GET /matches/1
  def show
    render json: @match
  end

  # POST /matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /matches/1
  def update
    if @match.update(match_params)
      render json: @match
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end

  # DELETE /matches/1
  def destroy
    @match.destroy
  end
  def filter_by
    # params[:something] = params[:player_name] | params[:match_code]
    @labs = Match
                   .joins(:tournament, player_matches: :player)
                   .where('players.player_name' => params[:player_name]).or(
        Match
            .joins(:tournament, player_matches: :player)
            .where('tournaments.tournament_name' => params[:tournament_name])
    )

    # @matches = Match
    #                .joins(player_matches: :player)
    #                .where('players.player_name' => params[:player_name])
    #         .where('matches.match_code' => params[:match_code])
    render json: @labs
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_match
      @match = Match.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def match_params
      params.require(:match).permit(:match_code, :match_time, :match_date, :venue_id)
    end
end
