# frozen-string_literal: true

# Rails routing file
Rails.application.routes.draw do
  
  resources :userclasses
  resources :classrooms do
    resources :announcements
    resources :classworks
    resources :submissions
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :reports, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts do
    resources :comments
    resources :suggestions
  end
  authenticated :user do
    root to: 'classrooms#index'
  end
  root to: redirect('/users/sign_in')
  get 'status/:id', to: 'moderators#status'
  get 'join_class', to: 'userclasses#new'
  get 'moderator', to: 'moderators#index'
  get 'user/:user_id/posts', to: 'posts#index'
  get 'user/:user_id/suggestions', to: 'suggestions#index'
  post 'submission', to: 'submissions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
