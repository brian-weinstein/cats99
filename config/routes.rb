Rails.application.routes.draw do
  resources :cat_rental_requests, only: [:new,:create] do
    member do
      post :approve
      post :deny
    end
  end
  resources :cats
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "cats#index"
end
