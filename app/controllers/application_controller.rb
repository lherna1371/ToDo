class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  private
  
  def require_user
    if (session[:passid].blank?) || (session[:passtoken].blank?)
      redirect_to root_url
    end
  end

  helper_method :require_user

end
