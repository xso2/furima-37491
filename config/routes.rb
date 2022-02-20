Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'

# resources :user, [:new, :create]
  resources :items
end
