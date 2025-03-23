# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      get '/', to: 'dashboard#index'
    end
  end

  root 'home#index'

  resources :quizzes do
    resources :evaluations
  end

  resources :tags, only: [:show, :index]
  resources :pages
  resources :questions
  resources :evaluations

  resources :posts do
    resources :comments
    member do
      put 'like',    to: 'posts#upvote'
      put 'dislike', to: 'posts#downvote'
    end
  end

  resource :user,      only: [:show, :edit, :update], path: 'profile'
  resource :dashboard, only: [:show]
  resource :session
  resources :passwords, param: :token

  get '/service-worker.js',        to: 'service_worker#service_worker'
  get '/manifest.json',            to: 'service_worker#manifest'
  get '/offline.html',             to: 'service_worker#offline'
  get 'up' => 'rails/health#show', as: :rails_health_check
end
