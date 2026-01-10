class ApiController < ActionController::API
  before_action :authenticate_user!

  def current_organization
    @current_organization ||= current_user.organization
  end

  def scoped_subscriptions
    current_organization.subscriptions
  end
end
