Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  namespace :api, defaults: { format: :json } do
    resources :posts, only: [:index, :show] do
      resources :comments, only: [:index, :create]
    end
  end

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  match '*path', to: redirect('/'), via: :all
  get "up" => "rails/health#show", as: :rails_health_check
end
