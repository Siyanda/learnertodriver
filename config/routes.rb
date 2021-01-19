Rails.application.routes.draw do
require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
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

  resources :users
  resources :posts do
    resources :comments
  end

  get '/service-worker.js' => 'service_worker#service_worker'
  get '/manifest.json' => 'service_worker#manifest'
  get '/offline.html' => 'service_worker#offline'
end