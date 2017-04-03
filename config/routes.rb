Rails.application.routes.draw do



  get 'pages/about'

  get 'pages/contact'

  post '/products', to: 'products#filter_data'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources 'products', only: [:index, :show]

  root to: 'products#index'
end
