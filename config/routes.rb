Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  root to: 'jobs#index'
  resources :jobs, only: [:show, :new, :create, :edit, :update] do
    resources :quotes, only: [:create, :update]
    resources :payments, only: [:new, :create]
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

