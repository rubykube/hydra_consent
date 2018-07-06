Rails.application.routes.draw do
  get  '/login', to: 'sessions#new'
  post  '/login', to: 'sessions#create'

  get  '/consent', to: 'consent#new'
  post  '/consent', to: 'consent#create'
end
