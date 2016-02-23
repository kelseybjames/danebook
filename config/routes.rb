Rails.application.routes.draw do
  resources :users do
    resource :profile, except: [:new, :destroy]
    resources :photos do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Photo' }
      resources :comments, defaults: { commentable: 'Photo' }
    end

    resources :posts do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Post' }
      resources :comments, defaults: { commentable: 'Post' }
    end
  end

  resources :friendings, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
