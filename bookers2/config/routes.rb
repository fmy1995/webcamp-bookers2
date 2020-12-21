Rails.application.routes.draw do
  get 'search/search'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  get '/search' => 'search#search'

resources :users, only: [:show, :edit, :index, :update] do
      member do
        get :followeds, :followers
      end
    end
 resources :relationships, only: [:create, :destroy]

 resources :books do
  resources :book_comments, only: [:create, :destroy]
  resource :favorites, only: [:create, :destroy]
 end

end