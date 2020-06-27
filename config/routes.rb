# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    resources :test, only: [:index]

    resources :receipts, only: [:create, :show, :index, :destroy] do
      collection do
        post :analyze
      end
    end

    post '/google_oauth2', to: 'google_oauth2#authenticate'
  end
end
