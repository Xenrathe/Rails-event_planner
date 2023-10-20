Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :adventures, only: [:index, :new, :create, :show] do
    member do
      post 'attend'
    end
  end
  
  resources :users, only: [:show]

  resources :characters, only: [:show, :new, :create, :edit, :update] do
    member do
      patch 'set_active'
    end
  end

  # Defines the root path route ("/")
  root "adventures#index"
end
