Rails.application.routes.draw do
require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
    resource :admin, only: %[show]
    resources :pages, only: %[edit]
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

  resource :dashboard, only: %[show]
  resources :users, only: %i[show edit]
  resources :quizzes, only: %i[index show], path: 'tests'
  resources :evaluations
  resources :pages, only: %i[index show]

  resources :posts do
    resources :comments
    member do
      put 'like', to:    'posts#upvote'
      put 'dislike', to: 'posts#downvote'
    end
  end

  get '/service-worker.js' => 'service_worker#service_worker'
  get '/manifest.json' => 'service_worker#manifest'
  get '/offline.html' => 'service_worker#offline'
end
