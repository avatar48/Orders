Rails.application.routes.draw do
  get 'stocks/list'

  get 'stocks/edit'

  get 'invoices/list'
  get 'invoices/edit'
 


  root 'stocks#list'

  controller :stocks do  
    post 'upload_stock' => :upload_stock

  end

  controller :invoices do  
    post 'upload_invoice' => :upload_invoice
    post 'send_invoice' => :send_invoice
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
