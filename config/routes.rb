require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  resources :configurations
  resources :projects
  resources :commits
  resources :rule_sets
  resources :rules

  namespace :api, path: '', constraints: { subdomain: 'api' }, defaults: { format: :json } do
    namespace :v1 do
      resources :configurations
      resources :projects
      resources :commits do
        collection do
          get 'wipe'
        end
      end
      resources :rule_sets
      resources :rules
    end
  end

  get 'dashboard/index'
  get 'configurations/index'
  get 'projects/index'
  get 'commits/index'
  get 'rule_sets/index'
  get 'rules/index'

  mount Sidekiq::Web => '/sidekiq'

  root 'dashboard#index'
end
