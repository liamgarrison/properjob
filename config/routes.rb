Rails.application.routes.draw do
  root to: 'pages#home'
  resources :jobs, only: [:show, :new, :create, :edit, :update, :index] do
    resources :quotes, only: [:create, :update]
    resources :payments, only: [:new, :create]
    resources :messages, only: [:index, :create]
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

