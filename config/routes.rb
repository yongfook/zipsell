Rails.application.routes.draw do

  devise_for :admins, controllers: { registrations: "registrations", sessions: "sessions" }

  namespace :admin do
    resources :customers, only: [:index, :show]
  end

  resources :payments
  resources :products
  resources :links

  get 'view/:id', to: 'products#shop_show', as: 'shop_product'
  get 'success/:id', to: 'payments#success', as: 'success'
  get 'error', to: 'payments#error', as: 'error'
  get 'admin', to: 'payments#dashboard', as: 'dashboard'
  get '/payments/:id/create_and_send_new_link', to: 'payments#create_and_send_new_link', as: 'payment_create_and_send_new_link'

  root 'products#shop'

end
