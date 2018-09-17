Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "registrations", sessions: "sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :products
  resources :payments
  resources :links
  get 'success/:id', to: 'payments#success', as: 'success'
  get 'error', to: 'payments#error', as: 'error'
  get 'admin', to: 'payments#dashboard', as: 'dashboard'
  get '/payments/:id/create_and_send_new_link', to: 'payments#create_and_send_new_link', as: 'payment_create_and_send_new_link'
  root 'products#shop'
end
