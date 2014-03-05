class Api::V1::AdminOrganizationsController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def show
        admin_organizations = Organization.where(:id => OrganizationAdmin.where(:user_id =>current_user.id).pluck(:organization_id))
	render :status => 200,
           :json => { :success => true,
                      :info => "Organizations Fetched",
                      :data => {:admin_organizations => admin_organizations}
                               
                    }
  end
end
