class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?


  rescue_from 'Workflow::NoTransitionAllowed' do |exception|
    redirect_to root_path,alert:"İş akışında kabul edilemiyen adım."
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


end
