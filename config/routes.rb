Rails.application.routes.draw do
  resources :users do
    get 'newsfeed'
    resources :friendings, only: [:index]
    resource :profile, except: [:new, :destroy]
    resources :photos do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Photo' }
      resources :comments, defaults: { commentable: 'Photo' } do
        resources :likes, only: [:create, :destroy], defaults: { likeable: 'Comment' }
      end
    end

    resources :posts do
      resources :likes, only: [:create, :destroy], defaults: { likeable: 'Post' }
      resources :comments, defaults: { commentable: 'Post' } do
        resources :likes, only: [:create, :destroy], defaults: { likeable: 'Comment' }
      end
    end
  end

  resources :friendings, only: [:create, :destroy]
  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
end
