class Api::V1::MyFavoritesController < ApplicationController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  # Just skip the authentication for now
   before_filter :authenticate_user!

  respond_to :json

  def create
    user_follow_org = FollowOrganization.find_by_user_id_and_organization_id(current_user.id,params[:favorite][:id])
    if user_follow_org.nil?
      FollowOrganization.create({:user_id => current_user.id, :organization_id => params[:favorite][:id]})
    else
      user_follow_org.delete
    end
	render :status => 200,
           :json => { :success => true,
                      :info => "Favorite Toggled",
                      :data => {
                               }
                    }
  end
end
