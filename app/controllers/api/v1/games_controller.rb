class Api::V1::GamesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def index
    myteams = Team.where(:organization_id => FollowOrganization.where( :user_id => current_user.id ).pluck(:organization_id)).pluck(:id)
    home_teams = HomeTeam.where(:team_id => myteams).pluck(:game_id) 
    away_teams = AwayTeam.where(:team_id => myteams).pluck(:game_id)
    my_game_ids = home_teams | away_teams
    
    earlydate = Date.today - 2
    latedate = Date.today + 2

    my_games = Game.where( :id => my_game_ids ).where(["date > ?", earlydate]).where(["date < ?", latedate]).order('date asc')
   
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { 
				   "games" => my_games
                               } 
                    }
	
  end
end
