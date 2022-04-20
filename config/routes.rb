Rails.application.routes.draw do
  root to: 'home#index'
  resources :menus
  resources :orders
  patch '/orders/status/:id', to: 'orders#change_status'
  get '/reports/today', to: 'reports#get_todays_report'
end
