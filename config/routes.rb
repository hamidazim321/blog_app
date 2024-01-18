Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  match '*path', to: redirect('/'), via: :all
  get "up" => "rails/health#show", as: :rails_health_check
end
