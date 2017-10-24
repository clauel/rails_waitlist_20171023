require "sidekiq/web"

Rails.application.routes.draw do
  root 'requests#new'
  resources :requests, only: [:new, :create]
  resources :request_activations, only: [:edit]
  resources :request_confirmations, only: [:edit]


  mount Sidekiq::Web => '/sidekiq'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
