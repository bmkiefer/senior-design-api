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
                      :info => "Game Created",
                      :data => {
					:organizations => organizations
				} }
  end


  def create
   game = Game.create(:home_score => 0, :away_score => 0)
  # home_organization
  # away_organization
   render :status => 200,
           :json => { :success => true,
                      :info => "Game Created",
                      :data => {} }
  end

  def destroy
   Game.find(params[:game][:id]).destroy
   render :status => 200,
           :json => { :success => true,
                      :info => "Game Deleted",
                      :data => {} }
  end

end
