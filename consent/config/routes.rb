Rails.application.routes.draw do
  get  '/login', to: 'auth#new'
  post  '/login', to: 'auth#create'

  get  '/consent', to: 'consent#new'
  post  '/consent', to: 'consent#create'
end
