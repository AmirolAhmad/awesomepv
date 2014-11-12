class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include Authenticable

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale }
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def user_params
    params.require(:user).permit(:id, :username, :email,
      profile_attributes: [:id, :user_id, :full_name, :facebook_id])
  end

  def video_params
    params.require(:video).permit(:id, :user_id, :title, :description, :source, :youtube_id, :featured)
  end

  def picture_params
    params.require(:picture).permit(:id, :user_id, :title, :content, :cover_photo, :featured)
  end
end
