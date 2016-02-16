Rails.application.routes.draw do
  resources :users do
    resource :profile
    resources :posts do
      resources :post_likings, only: [:create, :destroy]
      resources :comments, defaults: { commentable: 'Post' }
    end
  end

  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
