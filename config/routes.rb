Blogosphere::Application.routes.draw do
  devise_for :users

  # Static pages
  get "editors/index"
  get "about/index"

  # Resources

  # Cart is only used as a controller to add/delete/view to the cart
  resources :cart, :only => [:index, :create, :destroy] 

  # Magazines is the controller that shows all the magazines in a list.
  resources :magazines, :only => [:index]

  # Checkout is the controller that makes the payment and saves the payment information to the DB
  resources :checkout, :only => [:new, :create]
  post "checkout/new"
  get "checkout/mandril_mailer"

  root :to => 'home#index'
end
