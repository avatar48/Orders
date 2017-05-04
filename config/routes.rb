Rails.application.routes.draw do
  get 'orders/edit'

  get 'orders/list'
  root 'orders#list'

  controller :orders do  
    post 'upload' => :upload

  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
