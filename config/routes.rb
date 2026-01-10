Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  
  namespace :api do
    resources :subscriptions, only: [:index, :show, :create, :update, :destroy]
end
