class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?, :require_admin, :require_user # in order to use them in the html.reb
  private
      def current_user
        # trying to get the current user
        #use the memoization pattern if the user already exists
        current_user ||= User.find(session[:user_id]) if session[:user_id]
      end

      def logged_in?
        !!current_user  # wether true or false

      end

      def require_user
        if !logged_in?
          flash[:danger] = "You need to be logged in to perform that action"
          redirect_to (root_path) and return
        end
      end

      def require_admin
        # these function to flash the errors and redirect 
        if logged_in? and !current_user.admin?
          flash[:danger] = "You are not allowed to delete Users"
          redirect_to (articles_path) and return
        end
      end
end
