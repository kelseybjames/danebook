Rails.application.routes.draw do
  resources :users do
    resource :profile
    resources :posts
  end

  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
