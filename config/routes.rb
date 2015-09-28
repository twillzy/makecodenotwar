Rails.application.routes.draw do

  root :to => 'home#index'

  resources :users do
    member do
      get 'profile'
      get 'matches'
    end
  end

  get 'auth/facebook/callback', to: "sessions#create"

  # When user clicks 'sign_out', destroy session
  match 'sign_out', to: "sessions#destroy", via: :delete

  post 'create_friendship' => 'friendships#create'
  delete 'delete_friendship' => 'friendships#destroy'

  get 'matches/get_email' => 'users#get_email'

end
