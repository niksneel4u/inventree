# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  get 'marketplaces/:id/add_mappings', to: 'marketplaces#add_mappings', as: 'marketplace_add_mappings'
  patch 'marketplaces/:id/save_mappings', to: 'marketplaces#save_mappings', as: 'marketplace_save_mappings'
  resources :home, :entities, :marketplaces

  get 'homes/getproductdetail', to: 'homes#getproductdetail', as: 'getdata'
  get 'homes/index', to: 'homes#index'

  root 'marketplaces#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
