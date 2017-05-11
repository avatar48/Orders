Rails.application.routes.draw do
  get 'invoices/list'
  get 'invoices/edit'
  get 'documets/show'

  get 'orders/edit'

  get 'orders/list'
  root 'orders#list'

  controller :orders do  
    post 'upload' => :upload

  end

  controller :invoices do  
    post 'upload_invoice' => :upload_invoice

  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
