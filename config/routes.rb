Rails.application.routes.draw do

  get 'order_data/alldata'
  get 'schedules/today'
  get 'welcome/index'
  get 'backups/index'
  post 'backups/call_dump'
  post 'backups/call_restore'

  resources :bills do
    get :autocomplete_client_name, on: :collection
    get :autocomplete_perfume_name, on: :collection
    resources :payments
  end

  resources :order_data do
    get :autocomplete_client_name, on: :collection
    resources :orders do
      get :autocomplete_perfume_name, on: :collection
    end
  end

  resources :clients do
    resources :schedules
    get :autocomplete_postal_code_c_postal, on: :collection
  end

  resources :perfumes

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
