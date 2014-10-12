Rails.application.routes.draw do
  root "sessions#index"

  get "/login", to: "sessions#new", as: "login"

  resources :sessions, only: [:create, :index, :destroy]
  resources :profiles, only: [:show]
  resources :rants, only: [:show, :index] do
    resources :comments, only: [:new, :create, :index]
  end


  resource :user, only: [:new, :create, :edit, :update] do
    resources :interesting_ranters, only: [:index, :create, :destroy]
    resource :dashboard, only: [:show]
    resources :rants, only: [:create, :destroy]
    resources :favorites
  end

  resources :admin_rants, only: [:index]
  resources :admin_users, only: [:index, :update]

end
