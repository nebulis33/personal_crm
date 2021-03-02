Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index, :show]
  resources :contacts

  devise_for :users, path: 'member'
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
end
