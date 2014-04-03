class Api::V1::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    admin_roles = OrganizationAdmin.where(:user_id =>current_user.id).pluck(:organization_id) 

    if admin_roles.length == 0
      admin_token = false;
    else
      admin_token = true;
    end

    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :data => { :auth_token => current_user.authentication_token,
			         :admin_token => admin_token	
			       } }
  end

  def destroy
    warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
    current_user.update_column(:authentication_token, nil)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged out",
                      :data => {} }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end
