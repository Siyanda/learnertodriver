# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    mount MissionControl::Jobs::Engine, at: '/jobs'

    resources :users, :tags, :taggings, :comments, :responses, :quizzes,
              :questions, :posts, :pages, :notifications,
              :evaluations, :choices,
              :answers, :admin_users

    get    '/',        to: 'home#index'
    get    'sign_in',  to: 'sessions#new'
    post   'sign_in',  to: 'sessions#create'
    delete 'sign_out', to: 'sessions#destroy'
    resource :password_reset

    get '/', to: 'dashboard#index'
  end

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
    resources :evaluations, only: %i[new create show edit update]
  end

  get '/manifest.json',            to: 'service_worker#manifest'
  get '/offline.html',             to: 'service_worker#offline'
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'home#index'
end
