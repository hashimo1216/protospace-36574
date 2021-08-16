class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  private
  
  def configure_permitted_parameters
    added_attrs = [ :email, :name, :password, :profile, :occupation, :position ]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

end
