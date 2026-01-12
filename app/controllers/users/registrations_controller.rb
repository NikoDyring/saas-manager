# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  
  def respond_with(current_user, _opts = {})
    if resource.persisted?  
      render json: { message: 'Signed up successfully', user: current_user }, status: :ok
    end
  end
end
