Rails.application.routes.draw do

  root :to => 'home#index'

  resources :users do
    member do
      get 'profile'
      get 'matches'
    end
  end

  get 'auth/facebook/callback', to: "sessions#create"
  match 'sign_out', to: "sessions#destroy", via: :delete

end
