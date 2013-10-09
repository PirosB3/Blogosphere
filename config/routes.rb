Blogosphere::Application.routes.draw do
  devise_for :users

  # Static pages
  get "editors/index"
  get "about/index"

  # Resources

  # Cart is only used as a controller to add/delete/view to the cart
  resources :cart, :only => [:index, :create, :destroy] 

  # Magazines is the controller that shows all the magazines in a list.
  get "magazines/purchased", :as => 'purchased_magazines'
  resources :magazines, :only => [:index, :show]

  # Checkout is the controller that makes the payment and saves the payment information to the DB
  resources :checkout, :as => :checkouts, :only => [:new, :create]

  root :to => 'home#index'

  namespace :administration do
    resources :checkouts, :only => [:index, :show, :update]
  end
end
