class ApplicationController < ActionController::Base
  before_action :authenticate_user!,except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_log_in_path_for(resource)
    user_path(current_user.id)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
    :email,
    :name,
    :postcode,
    :prefecture_name,
    :address_city,
    :address_street,
  ])
    devise_parameter_sanitizer.permit(:sign_in,keys:[:name])
  end

end
