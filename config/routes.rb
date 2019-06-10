Rails.application.routes.draw do
  root to: 'pages#home'
  resources :jobs, only: [:show, :new, :create, :edit, :update, :index] do
    resources :quotes, only: [:create, :update]
    resources :payments, only: [:new, :create]
    resources :messages, only: [:index, :create]
  end

  devise_for :users

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :jobs, only: [ :index, :show ]
    end
  end
end

