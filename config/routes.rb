Rails.application.routes.draw do
  devise_for :users

  resources :contacts, only: [:index]
  resources :imports, only: [:index, :new, :create]
  resources :contact_import_logs, only: [:index]

  root to: 'contacts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
