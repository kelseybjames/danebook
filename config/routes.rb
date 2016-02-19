Rails.application.routes.draw do
  resources :users do
    resource :profile, except: [:new, :destroy]
    resources :posts do
      resources :post_likings, only: [:create, :destroy]
      resources :comments, defaults: { commentable: 'Post' }
    end
  end

  resources :friendings, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
