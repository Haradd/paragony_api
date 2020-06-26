# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :test, only: [:index]

    post '/google_oauth2', to: 'google_oauth2#authenticate'
  end
end
