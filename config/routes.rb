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



  get 'auth/facebook/callback', to: "sessions#create"

  # When user clicks 'sign_out', destroy session
  match 'sign_out', to: "sessions#destroy", via: :delete

  post 'create_friendship' => 'friendships#create'
  delete 'delete_friendship' => 'friendships#destroy'

  get 'matches/get_email' => 'users#get_email'


  get 'matches/get_question' => 'users#get_question'
<<<<<<< HEAD
  post 'matches/put_solution' => 'users#put_solution'
=======

  post 'matches/post_solution' => 'users#post_solution' 
>>>>>>> f20ed0f70e99f10f0d72edb3286eb499b7097751

  resources :conversations do
    resources :messages
  end


end

