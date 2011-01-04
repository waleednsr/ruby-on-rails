# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  include AuthenticatedSystem
   def admin_required
     unless current_user || current_user.is_admin?
      flash[:error]="Sorry, You don't have access to that"
      redirect_to root_url and return false
     end
    end
rescue_from CanCan::AccessDenied do |exception|
flash[:error] = exception.message
redirect_to root_url
end
end
