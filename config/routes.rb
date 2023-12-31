# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?
  get "/appointments/available_slots", to: "available_slots#show"
  root "patients#index"
  get "patients/:patient_id/appointments", to: "appointments#index", as: :patient_appointments
  get "/appointments", to: "appointments#index", as: :all_appointments
  get "/chart", to: "chart#show"

  resources :appointments, only: %i[show edit update destroy]

  resources :patients, only: [:index] do
    resources :appointments, only: %i[new create]
  end
end
