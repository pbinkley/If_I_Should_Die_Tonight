Rails.application.routes.draw do
  resources :categories
  get 'welcome/index'
  get '/items/charts', to: 'items#charts'
  resources :items
  root 'welcome#index'
end
