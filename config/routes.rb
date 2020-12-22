Rails.application.routes.draw do
  devise_for :users, :controllers=> { :registrations=> 'user/registrations'}
  root 'welcome#index'
  get 'about', to: "welcome#about"
  get 'my_stocks', to: "users#my_stocks" 
  get 'stock_search', to: "stocks#search"
  get 'chatroom', to: "chatroom#index"
  resources :user_stocks, only: [:create, :destroy]
  get 'search_users', to: "users#search"
  get 'friends', to: 'users#friends'
  resources 'messages', only: [:create]
  resources :users, only: [:index, :show] do
    resources :friendships, only: [] do
      collection do
        post :add, to: 'friendships#add'
        post :unfriend, to: 'friendships#unfriend'
        post :accept, to: 'friendships#accept'
        post :reject, to: 'friendships#reject'
        post :cancelled, to: 'friendships#cancelled'
        post :block, to: 'friendships#block'
        post :unblock, to: 'friendships#unblock'
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
