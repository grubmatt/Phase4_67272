Rails.application.routes.draw do
  resources :users
  resources :store_flavors
  resources :flavors
  resources :jobs
  resources :shift_jobs
  resources :shifts
  # Routes for main resources
  resources :stores
  resources :employees
  resources :assignments

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  
  # Set the root url
  root :to => 'home#home'  
  
end
