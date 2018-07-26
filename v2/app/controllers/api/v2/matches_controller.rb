class ::Api::V2::MatchesController < ApplicationController
  before_action :set_match, only: %i[show update destroy]

  # GET /matches
  def index
    if params[:player_name].present?
      @matches = Match.filter_by_player_name(params[:player_name])
    elsif params[:tournament_name].present?
      @matches = Match.filter_by_tournament_name(params[:tournament_name])
    else
      @matches = Match.all
    end
    render json: @matches
  end

  # GET /matches/1
  def show
    render json: @match
  end
  def show_player_result
    @result = Match.show_player_result(params[:temp])
    render json: @result
  end

  # POST /matches
  def create
    @match = Match.new(match_params)

    if @match.save
      render json: @match, status: :created, location: api_v2_match_url(@match)
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

  def import

    Match.import(params[:file])

    render json:
               {
                 status: 200,
                 message: 'CSV file has been imported successfully'
               }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_match
    @match = Match.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def match_params
    params.require(:match).permit(:code, :time, :date, :player1_id, :player2_id, :score1, :score2, :venue_id, :tournament_id)
  end
end
