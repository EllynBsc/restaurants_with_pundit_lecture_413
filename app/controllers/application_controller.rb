class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit #loading all the code of pundit generated so you can have access to all the method of the gem

  # Pundit: white-list approach.
  # white-list approach: everything is forbidden.
  # verify_authorized is an authorization happening on a specific instance, for ex @restaurant
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # veryify_policy_scoped is an authorization happening on the class level Restaurant (index)

  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # rescue_from the error message/page notauthorized from pundit, with the customised method  user_not_autorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    # if your cointroller is a devise controller or the controller is a controller for admin or a static controlelr pages
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
