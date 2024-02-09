# frozen_string_literal: true

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      get '/', to: 'dashboard#index'
    end
  end

  root 'home#index'

  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               confirmations: 'users/confirmations',
               passwords: 'users/passwords',
               unlocks: 'users/unlocks',
               registrations: 'users/registrations'
             },
             path: '/',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             }

  resources :quizzes do
    resources :evaluations
  end

  resource :dashboard, only: %(show)
  resources :tags, only: %i[show index]
  resources :pages
  resources :photos
  resources :questions
  resources :evaluations

  resources :posts do
    resources :comments
    member do
      put 'like', to: 'posts#upvote'
      put 'dislike', to: 'posts#downvote'
    end
  end

  get '/service-worker.js', to: 'service_worker#service_worker'
  get '/manifest.json', to: 'service_worker#manifest'
  get '/offline.html', to: 'service_worker#offline'
end
