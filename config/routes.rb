# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user,      path: 'profile'
  resource :dashboard, only: :show
  resource :session

  resources :passwords, param: :token
  resources :pages
  resources :questions
  resources :evaluations
  resources :tags, only: %i[show index]

  resources :quizzes do
    resources :evaluations
  end

  resources :posts do
    resources :comments
  end

  namespace :admin do
    get '/', to: 'dashboard#index'

    resources :pages, :posts, :users, :questions,
              :evaluations, :tags, :comments, :quizzes
  end

  get '/manifest.json',            to: 'service_worker#manifest'
  get '/offline.html',             to: 'service_worker#offline'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
