Rails.application.routes.draw do

  devise_for :users
  get 'persons/profile'

  get 'leftovers/send'

  resources :partners, expect: [:index, :show, :edit, :new, :create]

  resources :stocks, expect: [:index, :show]
  resources :invoices, expect: [:index, :show, :delete]
 
  root 'stocks#index'
  
  get 'persons/profile', as: 'user_root'

  controller :stocks do  
    post 'upload_stock' => :upload_stock
    post 'send_stock' => :send_stock
  end

  controller :invoices do  
    post 'upload_invoice' => :upload_invoice
    post 'send_invoice' => :send_invoice
  end

  controller :leftovers do  
    post 'send_leftovers' => :send_leftovers
  end
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
