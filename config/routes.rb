Rails.application.routes.draw do
  root "sessions#index"

  get "/login", to: "sessions#new", as: "login"

  resources :sessions, only: [:create, :index, :destroy]
  resources :profiles, only: [:show]
  resources :rants, only: [:show, :index, :update] do
    resources :comments, only: [:create]
  end


  resources :users, only: [] do
    resources :comments, only: [:create]
  end




  resource :user, only: [:new, :create, :edit, :update] do
    resources :interesting_ranters, only: [:index, :create, :destroy]
    resource :dashboard, only: [:show]
    resources :rants, only: [:create, :destroy]
    resources :favorites
  end

  resources :admin_rants, only: [:index, :destroy, :update, :show]
  resources :admin_users, only: [:index, :update]
  resource :admin_dashboards, only: [:show]

  resources :admin_sessions, only: [:create, :index, :destroy]

  get "/confirm_email/:confirmation_token", to: "email_confirmers#destroy", as: "email_confirmation"
  get "/login_impersonator", to: "admin_sessions#new", as: "login_impersonator"
end
