require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
  devise_for :users

  resources :lists do
    member do
      put :sort
    end
  end

  resources :tasks do
    member do
      put :sort
      post :join
      post :leave
    end
  end

  resources :categories, only: [ :new, :create ]

  namespace :api do
    resources :tasks, only: [ :index, :show, :update ]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check

    # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
    # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
    # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

    # Defines the root path route ("/")
    root "lists#index"
    get "/api", to: "api/tasks#index"
end
