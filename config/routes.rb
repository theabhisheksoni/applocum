Rails.application.routes.draw do
  root to: "home#index"
  resources :home, only: :index
  devise_for :users
  resources :users
  resources :appointments do
    get :accept, on: :member
    get :reject, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
