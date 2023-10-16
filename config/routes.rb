Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :events, only: [:index, :new, :create, :show] do
    member do
      post 'attend'
    end
  end
  
  resources :users, only: [:show]

  # Defines the root path route ("/")
  root "events#index"
end
