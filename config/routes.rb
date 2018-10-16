Rails.application.routes.draw do
  root 'interventions#new'

  resources :interventions, only: %i[new create destroy]

  namespace :admin do
    root 'calendars#index'
    resources :calendars do
      resources :openings
    end
    resources :appointments
    resources :interventions
  end
end
