Rails.application.routes.draw do
  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end

  root to: "posts#index"

  
  resources :users

  resource :session, only: [:new, :create, :destroy]

  patch '/users/pswd/:id/', {to: 'users#updatepswd' , as: :update_pswd}

end
