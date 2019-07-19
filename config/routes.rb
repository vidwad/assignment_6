Rails.application.routes.draw do
  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end

  root to: "posts#index"
end
