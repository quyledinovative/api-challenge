class CsvFilesController < ApplicationController
  before_action :set_csv_file, only: [:show, :update, :destroy]

  # GET /csv_files
  def index
    @csv_files = CsvFile.all

    render json: @csv_files
  end

  # GET /csv_files/1
  def show
    render json: @csv_file
  end

  # POST /csv_files
  def create
    # @csv_file = CsvFile.new(csv_file_params)
    #
    # if @csv_file.save
    #   render json: @csv_file, status: :created, location: @csv_file
    # else
    #   render json: @csv_file.errors, status: :unprocessable_entity
    # end

    CsvFile.import(params[:file])
    render json:{
        status: 200,
        message: "CSV file has been imported successfully"
    }

  end

  # PATCH/PUT /csv_files/1
  def update
    if @csv_file.update(csv_file_params)
      render json: @csv_file
    else
      render json: @csv_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /csv_files/1
  def destroy
    @csv_file.destroy
  end
  def show_matches
    # params[:something] = params[:player_name] | params[:match_code]
    @matches = Match
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
    render json: @matches
  end
  def show_points
    @player_match = {'Player Name' => params[:player_name],
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

    render json:@player_match
    # @player_matches= PlayerMatch.joins(:player, :match)
    #                                       .where("player_matches.result" => 'Win')
    #
    # render json:@player_matches
  end
  def import
    CsvFile.import(params[:file])
    # redirect_to companies_path, notice: "Companies added successfully"
     render json:{
            status: 200,
            message: "CSV file has been imported successfully"
    }
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_csv_file
      @csv_file = CsvFile.find(params[:id])
    end
    # Only allow a trusted parameter "white list" through.
    def csv_file_params
      params.require(:csv_file).permit(:group_id, :match_id, :player_id, :venue_id, :player_match_id)
    end
  # post needs to permit parameters and get do not need WHY?
end
