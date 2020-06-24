Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'books#top'
  get 'home/about', to: 'books#about', as: 'home_about'
  resources :books
  resources :users do
  	resources :relationships, only: [:create, :destroy]
  get 'following', to: 'relationships#following', as: 'following'
  get 'follower', to: 'relationships#follower', as: 'follower'
  end
end

