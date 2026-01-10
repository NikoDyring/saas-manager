module Api
  class SubscriptionsController < ApiController
    def index
      @subscriptions = current_organization.subscriptions.includes(:vendor)

      render json: @subscriptions.as_json(include: :vendor)
    end

    def show
      @subscription = scoped_subscriptions.find(params[:id])

      render json: @subscription.as_json(include: :vendor)
    end
  end
end
