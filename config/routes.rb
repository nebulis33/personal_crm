Rails.application.routes.draw do
  root to: 'users#index'

  resources :users, only: [:index, :show]
  resources :contacts do
    resources :events, shallow: true
  end
  get '/events', to: 'events#overview'

  devise_for :users, path: 'member'
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'sign_up', to: 'devise/registrations#new'
  end
end
