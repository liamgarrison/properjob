Rails.application.routes.draw do
  root to: 'pages#home'
  resources :jobs, only: [:show, :new, :create, :edit, :update, :index] do
    resources :quotes, only: [:create, :update]
    resources :payments, only: [:new, :create]
    resources :messages, only: [:index, :create]
  end

  resources :properties, only: [:index, :show, :new, :create] do
    resources :tenancies, only: [:index, :show, :new, :create]
  end

  resources :tenancies, only: [:index, :show, :edit, :update]
  

  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :jobs, only: [ :index, :show, :update, :create ]
    end
  end
end

