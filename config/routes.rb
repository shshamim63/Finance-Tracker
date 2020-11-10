Rails.application.routes.draw do
  devise_for :users, :controllers=> { :registrations=> 'user/registrations'}
  root 'welcome#index'
  get 'my_portfolio', to: "users#my_portfolio" 
  get 'stock_search', to: "stocks#search"
  resources :user_stocks, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
