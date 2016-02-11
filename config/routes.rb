Rails.application.routes.draw do
  resources :users do
    resources :profiles
  end

  resource :session, only: [:new, :create, :destroy]
  
  root 'users#index'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
