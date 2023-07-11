# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "patients#index"

  resources :patients, only: [:index] do
    resources :appointments, only: %i[new create]
  end
end
