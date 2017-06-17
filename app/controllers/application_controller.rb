# Main controller other controllers inherit from
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_filter :verify_authenticity_token 
  protect_from_forgery with: :exception

  # Generic authentication call used on other pages
  def authenticate_user!
    redirect_to new_user_session_path,
                alert: 'You must login before viewing this page!' unless
                self.user_signed_in?
  end

  # CanCan
  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to main_app.root_path
  end
end
