class Api::V1::AdminGamesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def show
	admin_games = Game.where( :id =>  HomeTeam.where(:team_id => params[:team][:id]).pluck(:game_id))

	render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => {
                                   "admin_games" => admin_games
                               }
                    }
  end

  def update
   game = Game.find(params[:game][:id])

   game.update_column(:home_score, params[:game][:home_score])
   game.update_column(:away_score, params[:game][:away_score])

   render :status => 200,
           :json => { :success => true,
                      :info => "Update Score",
                      :data => {} }   
  end

end
