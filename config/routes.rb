Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :products
  resources :payments
  resources :links
  get 'admin', to: 'products#dashboard', as: 'dashboard'
  root 'products#shop'
end
