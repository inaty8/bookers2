Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get 'home/about' => 'homes#about', as: 'about'

  resources :users, only: [:show, :edit,:create,:index,:update]
  resources :books, only: [:create, :index, :show, :destroy,:update,:edit] do
    resources :book_comments, only: [:create,:destroy]
    resource :favorites, only: [:create, :destroy]
  end


end
