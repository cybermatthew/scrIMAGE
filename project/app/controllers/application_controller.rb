class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

	def current_user
		if logged_in?
  			@current_user = User.find(session[:id])
  		end
  		@current_user
	end

 	def logged_in?
   		session[:id] != nil
 	end
end
