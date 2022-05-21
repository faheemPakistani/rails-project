# frozen-string_literal: true

# Rails routing file
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :userclasses
  resources :classrooms do
    resources :announcements
    resources :classworks
    resources :submissions
  end

  resources :classworks do
    resources :submissions
  end

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
  get 'classrooms/:classroom_id/assignments', to: 'classworks#index'
  get 'assignment/:classwork_id/submissions', to: 'submissions#index'
  get 'user/:user_id/suggestions', to: 'suggestions#index'
  post 'submission', to: 'submissions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
