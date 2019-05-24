Rails.application.routes.draw do
  root to: 'jobs#index'
  resources :jobs, only: [:show, :new, :create] do
    resources :quotes, only: [:new, :create, :edit, :update, :index]
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

