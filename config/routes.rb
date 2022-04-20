Rails.application.routes.draw do
  root to: 'home#index'
  resources :menus
  resources :orders
  patch '/orders/status/:id', to: 'orders#change_status'
  get '/reports/today', to: 'reports#get_todays_report'
  get '/reports/customer/:email', to: 'reports#get_todays_report_by_email'
end
