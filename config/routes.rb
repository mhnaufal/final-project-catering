Rails.application.routes.draw do
  # Home
  root to: 'home#index'
  
  # Menu
  resources :menus

  # Order
  resources :orders
  patch '/orders/status/:id', to: 'orders#change_status'

  # Report
  get '/reports/today', to: 'reports#get_todays_report'
  get '/reports/customer/:email', to: 'reports#get_report_by_email'
  get '/reports/price/:total', to: 'reports#get_report_by_price'
  get 'reports/date/:date', to: 'reports#get_report_by_date'
end
