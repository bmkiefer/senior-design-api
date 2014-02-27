class Api::V1::MyOrganizationsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def index
	my_organizations = Organization.where(:id => FollowOrganization.where(:user_id =>current_user.id).pluck(:organization_id))
	render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => {:organizations => my_organizations}
                               
                    }
  end
end
