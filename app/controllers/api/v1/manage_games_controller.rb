class Api::V1::ManageGamesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def index
   organizations = Organization.all
   render :status => 200,
           :json => { :success => true,
                      :info => "Game Create Start",
                      :data => {
					:organizations => organizations
				} }
  end


  def create

   game_date = DateTime.new(params[:game][:year],params[:game][:month],params[:game][:day])
  
   home_org = Organization.find(params[:game][:home_organization])
  
   away_org = Organization.find(params[:game][:away_organization])
  
   game = Game.create(:home_score => 0, :away_score => 0, :sport => params[:game][:sport], :home_organization => home_org.name, :away_organization => away_org.name, :date => game_date )
   
   if Team.where(:organization_id => params[:game][:home_organization], :sport => params[:game][:sport]).length == 0
     Team.create(:organization_id => params[:game][:home_organization], :sport => params[:game][:sport])
   end

   if Team.where(:organization_id => params[:game][:away_organization], :sport => params[:game][:sport]).length == 0
     Team.create(:organization_id => params[:game][:away_organization], :sport => params[:game][:sport])
   end

   HomeTeam.create( :team_id => Team.where(:organization_id => params[:game][:home_organization], :sport => params[:game][:sport] ).pluck(:id).first, :game_id => game.id)
   AwayTeam.create( :team_id => Team.where(:organization_id => params[:game][:away_organization], :sport => params[:game][:sport] ).pluck(:id).first, :game_id => game.id)

   render :status => 200,
           :json => { :success => true,
                      :info => "Game Created",
                      :data => {} }
  end

  def destroy
 
   game = Game.find(params[:game][:id])

   HomeTeam.find(:game_id => game.id).destroy
   AwayTeam.find(:game_id => game.id).destroy

   game.destroy   

   render :status => 200,
           :json => { :success => true,
                      :info => "Game Deleted",
                      :data => {} }
  end

end
