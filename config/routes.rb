Rails.application.routes.draw do
  devise_for :admins, controllers: { registrations: "registrations"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  get 'admin', to: 'products#dashboard', as: 'dashboard'

end
