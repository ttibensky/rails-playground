Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  get '', to: 'fe/homepage#index'

  as :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'logout', to: 'devise/sessions#destroy'
  end

  namespace :app do
    namespace :listings do
      get '', action: 'index', as: ''
      get ':id', action: 'show', as: 'show'
      get ':id/reviews', action: 'reviews', as: 'reviews'
      post '', action: 'create', as: 'create'
    end
  end
end
