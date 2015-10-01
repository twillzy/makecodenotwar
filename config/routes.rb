Rails.application.routes.draw do

  root :to => 'home#index'

  resources :users do
    member do
      get 'profile'
      get 'matches'
      # resources :conversations do
      #   resources :messages
      # end
    end
  end

  get 'notifications' => 'users#notifications'

  get 'auth/facebook/callback', to: "sessions#create"

  # When user clicks 'sign_out', destroy session
  match 'sign_out', to: "sessions#destroy", via: :delete

  post 'create_friendship' => 'friendships#create'
  delete 'delete_friendship' => 'friendships#destroy'

  get 'matches/get_email' => 'users#get_email'


  get 'matches/get_question' => 'users#get_question'
  post 'matches/post_solution' => 'users#post_solution' 


  resources :conversations do
    resources :messages
  end


end

