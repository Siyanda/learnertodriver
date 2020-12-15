Rails.application.routes.draw do
#   # sidekiq web interface
#   require 'sidekiq/web'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'landing#index'

  devise_for :users,
  controllers: {
    sessions: 'users/sessions',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks',
    registrations: 'users/registrations'
  },
  :path => '/',
  :path_names => {
    :sign_in => 'login',
    :sign_out => 'logout'
  }

  resources :users
#   resources :posts do
#     resources :comments
#   end
end
