Rails.application.routes.draw do
  root 'interventions#new'

  resources :interventions, only: %i[new create destroy]

  resources :calendars, only: [:show] do
    member do
      get 'availabilities/:intervention_id', action: :availabilities, as: :availabilities
    end
  end

  namespace :admin do
    root 'calendars#index'
    resources :calendars do
      resources :openings
    end
    resources :appointments
    resources :interventions
  end
end
