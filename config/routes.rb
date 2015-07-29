Rails.application.routes.draw do
  # resource :users
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'marker_positions' => 'home#marker_positions'

  root :to => 'home#index'
end
