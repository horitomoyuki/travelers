class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:image, :name, :introduction, :age, :gender, :country_id, :job_id, :birthplace_id, :residence_id])
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
