# frozen_string_literal: true

Rails.application.routes.draw do
  root 'sessions#new'

  resources :sessions, only: :new do
    get :callback, on: :collection
  end
end
