# frozen_string_literal: true

Rails.application.routes.draw do
  resource :user,      path: 'profile'
  resource :dashboard, only: :show
  resource :session

  resources :passwords, param: :token
  resources :pages,     only: :show
  resources :tags,      only: %i[show index]

  resources :posts, only: %i[show index] do
    resources :comments
  end

  resources :quizzes, only: %i[show index] do
    resources :evaluations, only: %i[new create edit update]
  end

  namespace :admin do
    get '/', to: 'dashboard#index'

    resources :pages, :posts, :users, :questions,
              :evaluations, :tags, :comments, :quizzes

    mount MissionControl::Jobs::Engine, at: '/jobs'
  end

  get '/manifest.json',            to: 'service_worker#manifest'
  get '/offline.html',             to: 'service_worker#offline'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
