Rails.application.routes.draw do
  resources :jobs, only: [:index, :show] do
    resources :quotes, only: [:new, :create, :edit, :update, :index]
  end
  resources :jobs, only: [:index, :show, :new, :create]
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

