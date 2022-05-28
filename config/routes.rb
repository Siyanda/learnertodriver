Rails.application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/jobs'
    resource :admin, only: %(show)
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
    resources :evaluations do
    end
  end

  resource :dashboard, only: %(show)
  resources :users, only: %i[show edit]
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

  get '/service-worker.js' => 'service_worker#service_worker'
  get '/manifest.json' => 'service_worker#manifest'
  get '/offline.html' => 'service_worker#offline'
end
