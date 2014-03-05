class Api::V1::AdminTeamsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def show
	admin_teams = Team.where(:organization_id => params[:organization][:id])
	render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => {:admin_teams => admin_teams}
                               
                    }
  end
end
