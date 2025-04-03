# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin, constraints: AdminConstraint do
    get '/', to: 'dashboard#index'
  end

  resources :quizzes do
    resources :evaluations
  end

  resource :dashboard, only: [:show]
  resource :user,      only: %i[show edit update create new], path: 'profile'
  resource :session

  resources :passwords, param: :token

  resources :pages
  resources :questions
  resources :evaluations
  resources :tags, only: [:show, :index]

  resources :posts do
    resources :comments
    member do
      put 'like',    to: 'posts#upvote'
      put 'dislike', to: 'posts#downvote'
    end
  end

  get '/service-worker.js',        to: 'service_worker#service_worker'
  get '/manifest.json',            to: 'service_worker#manifest'
  get '/offline.html',             to: 'service_worker#offline'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
