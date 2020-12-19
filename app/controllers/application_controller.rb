class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_raven_context

  layout :determine_layout

  private
    def determine_layout
      current_user? ? "application" : "static"
    end

    def redirect_to_last_page(exception)
      redirect_to url_for(page: exception.pagy.last), notice: "Page ##{params[:page]} not found. Showing page #{exception.pagy.last} instead."
    end

  protected
  def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
   devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
   devise_parameter_sanitizer.permit(:account_update, keys: [:username, :first_name, :last_name])
  end
end