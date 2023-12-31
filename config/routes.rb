Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    get "search", to: "users#search"
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups, only: [:new, :create, :show, :index, :edit, :update] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
  end

  root to: "homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"
  get "tagsearches/search", to: "tag_searches#search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
